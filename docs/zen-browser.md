# Zen Browser

`dot_config/zen-chrome/userChrome.css` → `~/.config/zen-chrome/userChrome.css`. TokyoNight for Zen's chrome.

## Strategy

Zen does **not** theme via per-element backgrounds: it renders the whole chrome (sidebar, toolbar, urlbar, panels, popups) through a layered translucent overlay (`.zen-browser-generic-background`) driven by `--zen-*` variables from `chrome://browser/content/zen-styles/zen-theme.css`. Overriding individual elements with `!important` fights that overlay and leaves gaps.

Instead `userChrome.css` **overrides Zen's `--zen-*` theme variables** with TokyoNight values (plus a `--tg-*` palette: `#1a1b26` bg, `#16161e` panel, `#292e42` highlight, `#c0caf5` fg, `#565f89` comment, `#414868` border, `#7aa2f7` blue). Literal values, so `light-dark()` never picks the wrong branch.

## Applying it (manual — linker script removed)

The old `run_onchange_link-zen-chrome.sh.tmpl` was deleted; link by hand:

```sh
# for each profile dir in ~/.config/zen/profiles.ini:
mkdir -p ~/.config/zen/<profile>/chrome
ln -sf ~/.config/zen-chrome/userChrome.css ~/.config/zen/<profile>/chrome/userChrome.css
echo 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);' \
  >> ~/.config/zen/<profile>/user.js
```

Then restart Zen. (`chezmoi apply` updates the source; the symlink picks it up immediately.)
