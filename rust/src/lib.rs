use godot::prelude::*;

/// Hello, world!
struct MyExtension;

/// Hello, world!
#[gdextension]
unsafe impl ExtensionLibrary for MyExtension {}

#[derive(GodotClass)]
#[class(base=Sprite2D)]
/// Hello, world!
struct Player {
    /// Hello, world!
    base: Base<Sprite2D>,
}

use godot::classes::{ISprite2D, Sprite2D};

#[godot_api]
/// Hello, world!
impl ISprite2D for Player {
    /// Hello, world!
    fn init(base: Base<Sprite2D>) -> Self {
        Self { base }
    }
}

#[godot_api]
impl Player {
    /// Hello, world!
    #[func]
    pub fn foo(&self) -> f32 {
        0.0
    }
}