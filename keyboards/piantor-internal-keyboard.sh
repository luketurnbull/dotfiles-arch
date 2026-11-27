#!/bin/sh
set -eu

INTERNAL_NAME='AT Translated Set 2 keyboard'
EXTERNAL_VENDOR_ID='beeb'
EXTERNAL_MODEL_ID='0001'
LOCK_FILE='/run/piantor-internal-keyboard.lock'

usage() {
    printf 'Usage: %s {sync|enable|disable|status}\n' "${0##*/}" >&2
    exit 2
}

external_connected() {
    for device in /sys/bus/usb/devices/*; do
        [ -r "$device/idVendor" ] && [ -r "$device/idProduct" ] || continue
        [ "$(cat "$device/idVendor")" = "$EXTERNAL_VENDOR_ID" ] || continue
        [ "$(cat "$device/idProduct")" = "$EXTERNAL_MODEL_ID" ] || continue
        return 0
    done

    return 1
}

internal_inhibited_path() {
    path=''
    count=0

    for device in /sys/class/input/input*; do
        [ -r "$device/name" ] || continue
        [ "$(cat "$device/name")" = "$INTERNAL_NAME" ] || continue
        path="$device/inhibited"
        count=$((count + 1))
    done

    if [ "$count" -ne 1 ]; then
        printf 'Error: expected one "%s", found %s\n' "$INTERNAL_NAME" "$count" >&2
        return 1
    fi

    if [ ! -f "$path" ]; then
        printf 'Error: %s does not expose inhibited\n' "${path%/inhibited}" >&2
        return 1
    fi

    printf '%s\n' "$path"
}

require_root() {
    if [ "$(id -u)" -ne 0 ]; then
        printf 'Error: %s requires root\n' "${0##*/}" >&2
        exit 1
    fi
}

set_inhibited() {
    value="$1"
    path="$(internal_inhibited_path)"

    if [ ! -w "$path" ]; then
        printf 'Error: cannot write %s (run as root)\n' "$path" >&2
        return 1
    fi

    printf '%s\n' "$value" > "$path"

    if [ "$(cat "$path")" != "$value" ]; then
        printf 'Error: failed to set %s to %s\n' "$path" "$value" >&2
        return 1
    fi

    printf 'Internal keyboard inhibited=%s (%s)\n' "$value" "${path%/inhibited}"
}

sync_inhibited() {
    if external_connected; then
        set_inhibited 1
    else
        set_inhibited 0
    fi
}

lock_and_run() {
    require_root

    exec 9> "$LOCK_FILE"
    flock -x 9
    "$@"
}

case "${1-}" in
    sync)
        shift
        [ "$#" -eq 0 ] || usage
        lock_and_run sync_inhibited
        ;;
    enable)
        shift
        [ "$#" -eq 0 ] || usage
        lock_and_run set_inhibited 0
        ;;
    disable)
        shift
        [ "$#" -eq 0 ] || usage
        lock_and_run set_inhibited 1
        ;;
    status)
        shift
        [ "$#" -eq 0 ] || usage
        path="$(internal_inhibited_path)"
        if external_connected; then
            printf 'Piantor: connected (%s:%s)\n' "$EXTERNAL_VENDOR_ID" "$EXTERNAL_MODEL_ID"
        else
            printf 'Piantor: disconnected (%s:%s)\n' "$EXTERNAL_VENDOR_ID" "$EXTERNAL_MODEL_ID"
        fi
        printf 'Internal keyboard: %s\n' "${path%/inhibited}"
        printf 'inhibited=%s\n' "$(cat "$path")"
        ;;
    *)
        usage
        ;;
esac
