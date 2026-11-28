use amane::{Align::Center, Color, Radius, Rectangle, Size::Parent, Text, Weight};

pub fn view() -> Rectangle {
    let rect = Rectangle::new()
        .width(100.0)
        .height(Parent)
        .align_child(Center, Center)
        .fill("#000000")
        .blur(20.0)
        .radius(Radius::Full)
        .child(
            Text::new("18:45")
                .size(14.0)
                .color(Color::WHITE)
                .weight(Weight::Bold),
        );

    return rect;
}
