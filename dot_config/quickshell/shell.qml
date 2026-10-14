import Quickshell
import Quickshell.Hyprland

Scope {
    Bar {}

    GlobalShortcut {
        name: "toggle-sidebar"
        description: "Expand sidebar"
        onPressed: SidebarState.toggle()
    }
}
