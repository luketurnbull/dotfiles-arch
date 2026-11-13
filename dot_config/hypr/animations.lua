-- Material 3 "emphasized" curves: hard decel for enters, accel for exits
hl.curve("emphasizedDecel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("emphasizedAccel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

-- windows
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "emphasizedAccel", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "emphasizedDecel", style = "slide" })

-- workspaces (slide out / slide in; workspacesIn/Out inherit from parent)
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 4, bezier = "emphasizedDecel", style = "slidevert" })

-- fades
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "standard" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "emphasizedDecel" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "emphasizedAccel" })

-- layers
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "emphasizedDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "emphasizedAccel", style = "slide" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 4, bezier = "standard" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4, bezier = "standard" })

-- misc
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "standard" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 3, bezier = "standard" })
