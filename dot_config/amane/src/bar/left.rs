use amane::{
    Center, Color, Radius, Rectangle, Row, Service, Text, Weight::Bold, Widget, Workspace,
    Workspaces,
};

pub fn view() -> Row {
    let workspaces = Workspaces::read();

    let mut buttons: Vec<Box<dyn Widget>> = Vec::new();

    for workspace in workspaces.list() {
        buttons.push(Box::new(button(workspace)));
    }

    Row::new(buttons).gap(2.0)
}

fn button(workspace: &Workspace) -> Rectangle {
    let id = workspace.id();

    let rect = Rectangle::new()
        .width(32.0)
        .height(28.0)
        .align_child(Center, Center)
        .fill("000000")
        .blur(200.0)
        .radius(Radius::Full)
        .on_click(move |_| Workspaces::focus(id))
        .child(
            Text::new(workspace.index().to_string())
                .size(14.0)
                .weight(Bold)
                .color(Color::WHITE),
        );

    if workspace.focused() {
        return rect.opacity(0.9);
    }

    if workspace.windows() > 0 {
        return rect.opacity(0.5);
    }

    return rect.opacity(0.0);
}
