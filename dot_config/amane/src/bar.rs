mod left;

use amane::{Full, Layer, LayerWindow, Monitor, Parent, Rectangle, Vertical, Zone};

pub fn view(_: &Monitor) -> LayerWindow {
    LayerWindow::new()
        .width(Full)
        .height(24.0)
        .margin(amane::Margin {
            top: 2,
            right: 5,
            bottom: 0,
            left: 5,
        })
        .space(Zone::Reserve)
        .layer(Layer::Top)
        .anchor_vertical(Vertical::Top)
        .child(
            Rectangle::new()
                .width(Parent)
                .height(Parent)
                .child(left::view()),
        )
}
