mod left;
mod right;

use amane::{
    Align, Full, Justify, Layer, LayerWindow, Monitor, Parent, Rectangle, Row, Vertical, Zone,
    children,
};

pub fn view(_: &Monitor) -> LayerWindow {
    let columns = children![
        Rectangle::new()
            .width(Parent)
            .height(Parent)
            .child(left::view()),
        Rectangle::new()
            .width(Parent)
            .height(Parent)
            .align_child(Align::Center, Align::Center)
            .child(right::view()),
        Rectangle::new().width(Parent).height(Parent)
    ];

    LayerWindow::new()
        .width(Full)
        .height(28.0)
        .margin(amane::Margin {
            top: 10,
            right: 5,
            bottom: 8,
            left: 6,
        })
        .space(Zone::Reserve)
        .layer(Layer::Top)
        .anchor_vertical(Vertical::Top)
        .child(Row::new(columns).justify(Justify::Center))
}
