HOME=$(mktemp -d)
export HOME

mkdir -p "$HOME/.local/share/godot/export_templates/"
ln -s "${GODOT_EXPORT_TEMPLATES_DIR}/${GODOT_VERSION_DIR}" "$HOME/.local/share/godot/export_templates/$GODOT_VERSION_DIR"

mkdir build
cp "$GAME_SHARED_LIBRARY_OUT/lib/librust.so" "build/librust.so"

godot --path . --headless --export-debug "$GODOT_PRESET"
