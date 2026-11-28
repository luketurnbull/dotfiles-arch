use amane::{
    Center, Color, Parent, Rectangle, Row, Service, Text, Weight::Bold, Widget, Workspace,
    Workspaces,
};

pub fn view() -> Row {
    let workspaces = Workspaces::read();

    let mut buttons: Vec<Box<dyn Widget>> = Vec::new();

    for workspace in workspaces.list() {
        buttons.push(Box::new(button(workspace)));
    }

    Row::new(buttons).gap(4.0)
}

fn button(workspace: &Workspace) -> Rectangle {
    let id = workspace.id();

    let rect = Rectangle::new()
        .width(24.0)
        .height(Parent)
        .align_child(Center, Center)
        .fill("000000")
        .blur(20.0)
        .radius(10.0)
        .on_click(move |_| Workspaces::focus(id))
        .child(
            Text::new(workspace.index().to_string())
                .size(14.0)
                .weight(Bold)
                .color(Color::WHITE),
        );

    if workspace.focused() {
        return rect.border(1.0, "#FFFFFF");
    }

    if workspace.windows() > 0 {
        return rect.opacity(0.7);
    }

    return rect.opacity(0.25);
}
