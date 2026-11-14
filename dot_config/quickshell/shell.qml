import Quickshell

Scope {
    // Force-instantiate the singleton at startup — singletons are lazy,
    // and its GlobalShortcut must register before the first keypress.
    readonly property var _menuState: MenuState

    Bar {}
    StatsSidebar {}
}
