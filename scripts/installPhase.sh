install -D -m 755 -t "$out/share/TestProject" "./build/TestProject.x86_64"
install -D -m 644 -t "$out/share/TestProject" "./build/TestProject.pck"
install -D -m 644 -t "$out/share/TestProject" "./build/librust.so"
install -d -m 755 "$out/bin"

makeWrapper "$out/share/TestProject/TestProject.x86_64" "$out/bin/TestProject.x86_64" \
    --add-flags "--main-pack $out/share/TestProject/TestProject.pck"
