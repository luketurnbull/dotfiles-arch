use amane::{Align::Center, Color, Radius, Rectangle, Service, Size::Parent, Text, Weight};
use std::time::Duration;

struct Clock {
    time: String,
}

impl Service for Clock {
    fn new() -> Self {
        Self {
            time: amane::output("date +%H:%M"),
        }
    }

    fn interval() -> Duration {
        Duration::from_secs(10)
    }

    fn update(&mut self) -> bool {
        let time = amane::output("date +%H:%M");

        let changed = time != self.time;

        changed
    }
}

pub fn view() -> Rectangle {
    let clock = Clock::read();

    let rect = Rectangle::new()
        .width(100.0)
        .height(Parent)
        .align_child(Center, Center)
        .fill("#000000")
        .blur(20.0)
        .radius(Radius::Full)
        .child(
            Text::new(&clock.time)
                .size(14.0)
                .color(Color::WHITE)
                .weight(Weight::Bold),
        );

    return rect;
}
