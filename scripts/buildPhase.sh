HOME=$(mktemp -d)
export HOME

mkdir -p "$HOME/$GODOT_EXPORT_TEMPLATES_LOCAL_DIR"
ln -s "$GODOT_EXPORT_TEMPLATES_NIX_DIR/$GODOT_VERSION" "$HOME/$GODOT_EXPORT_TEMPLATES_LOCAL_DIR/$GODOT_VERSION"

mkdir build
cp "$GAME_SHARED_LIBRARY_OUT/lib/librust.so" "build/librust.so"

godot --path . --headless --export-debug "$GODOT_PRESET"
