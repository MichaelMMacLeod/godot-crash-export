Reproducer for a crash of the Godot editor when it is run in headless
mode and has a Rust gdextension.

Use the the following command to reproduce the crash (requires [Nix](https://nixos.org/download/)):


```sh
nix build
```

You may need to specify --experimental-features 'nix-command flakes' to enable flakes.

Example (using `-L` to get the full build log):

```sh
% nix build -L           
x86_64-linux-full> Running phase: unpackPhase
x86_64-linux-full> unpacking source archive /nix/store/xyx1y6n5r5mdi4l46bhszqxf6vj3r3zq-godot
x86_64-linux-full> source root is godot
x86_64-linux-full> Running phase: patchPhase
x86_64-linux-full> Running phase: updateAutotoolsGnuConfigScriptsPhase
x86_64-linux-full> Running phase: configurePhase
x86_64-linux-full> no configure script, doing nothing
x86_64-linux-full> Running phase: buildPhase
x86_64-linux-full> Godot Engine v4.5.1.stable.nixpkgs.f62fdbde1 - https://godotengine.org
x86_64-linux-full> 
x86_64-linux-full> ERROR: Cannot open X509CertificateMbedTLS file 'False'.
x86_64-linux-full>    at: load (modules/mbedtls/crypto_mbedtls.cpp:160)
x86_64-linux-full> [   0% ] first_scan_filesystem | Started Project initialization (5 steps)
x86_64-linux-full> [   0% ] first_scan_filesystem | Scanning file structure...
x86_64-linux-full> [  16% ] first_scan_filesystem | Loading global class names...
x86_64-linux-full> [  33% ] first_scan_filesystem | Verifying GDExtensions...
x86_64-linux-full> Initialize godot-rust (API v4.3.stable.official, runtime v4.5.1.stable.nixpkgs)
x86_64-linux-full> [  50% ] first_scan_filesystem | Creating autoload scripts...
x86_64-linux-full> [  66% ] first_scan_filesystem | Initializing plugins...
x86_64-linux-full> [  83% ] first_scan_filesystem | Starting file scan...
x86_64-linux-full> [ DONE ] first_scan_filesystem
x86_64-linux-full> 
x86_64-linux-full> [   0% ] reimport | Started (Re)Importing Assets (1 steps)
x86_64-linux-full> [   0% ] reimport | Preparing files to reimport...
x86_64-linux-full> [   0% ] reimport | Executing pre-reimport operations...
x86_64-linux-full> [   0% ] reimport | icon.svg
x86_64-linux-full> [  50% ] reimport | Finalizing Asset Import...
x86_64-linux-full> [ DONE ] reimport
x86_64-linux-full> 
x86_64-linux-full> [   0% ] reimport | Started (Re)Importing Assets (1 steps)
x86_64-linux-full> [   0% ] reimport | Executing post-reimport operations...
x86_64-linux-full> [ DONE ] reimport
x86_64-linux-full> 
x86_64-linux-full> [   0% ] savepack | Started Packing (102 steps)
x86_64-linux-full> [   1% ] savepack | Storing File: res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex
x86_64-linux-full> [   1% ] savepack | Storing File: res://icon.svg.import
x86_64-linux-full> [  33% ] savepack | Storing File: res://.godot/exported/133200997/export-14584830dbc22d3f76a596eed5f4948e-node_3d.scn
x86_64-linux-full> [  66% ] savepack | Storing File: res://TestProject.gdextension
x86_64-linux-full> [  66% ] savepack | Storing File: res://node_3d.tscn.remap
x86_64-linux-full> [  66% ] savepack | Storing File: res://.godot/global_script_class_cache.cfg
x86_64-linux-full> [  66% ] savepack | Storing File: res://icon.svg
x86_64-linux-full> [  66% ] savepack | Storing File: res://.godot/uid_cache.bin
x86_64-linux-full> [  66% ] savepack | Storing File: res://.godot/extension_list.cfg
x86_64-linux-full> [  66% ] savepack | Storing File: res://project.binary
x86_64-linux-full> [ DONE ] savepack
x86_64-linux-full> 
x86_64-linux-full> 
x86_64-linux-full> ================================================================
x86_64-linux-full> handle_crash: Program crashed with signal 11
x86_64-linux-full> Engine version: Godot Engine v4.5.1.stable.nixpkgs (f62fdbde15035c5576dad93e586201f4d41ef0cb)
x86_64-linux-full> Dumping the backtrace. Please include this when reporting the bug on: https://github.com/godotengine/godot/issues
x86_64-linux-full> [1] /nix/store/rcp9sdrrq8sfxkm5zdykglx7hd2gzbfy-glibc-2.40-66/lib/libc.so.6(+0x419c0) [0x7ffff2a419c0] (??:0)
x86_64-linux-full> [2] godot(+0x1a6d6de) [0x555556fc16de] (??:?)
x86_64-linux-full> [3] godot(+0x1a47a8c) [0x555556f9ba8c] (??:?)
x86_64-linux-full> [4] godot(+0x1a51bf5) [0x555556fa5bf5] (??:?)
x86_64-linux-full> [5] godot(+0x5089f31) [0x55555a5ddf31] (??:?)
x86_64-linux-full> [6] godot(+0x4d6989f) [0x55555a2bd89f] (??:?)
x86_64-linux-full> [7] godot(main+0x1aac) [0x555555c417ec] (??:?)
x86_64-linux-full> [8] /nix/store/rcp9sdrrq8sfxkm5zdykglx7hd2gzbfy-glibc-2.40-66/lib/libc.so.6(+0x2a4d8) [0x7ffff2a2a4d8] (??:0)
x86_64-linux-full> [9] /nix/store/rcp9sdrrq8sfxkm5zdykglx7hd2gzbfy-glibc-2.40-66/lib/libc.so.6(__libc_start_main+0x8b) [0x7ffff2a2a59b] (??:0)
x86_64-linux-full> [10] godot(+0x72fa05) [0x555555c83a05] (??:?)
x86_64-linux-full> -- END OF C++ BACKTRACE --
x86_64-linux-full> ================================================================
x86_64-linux-full> /nix/store/k5z8rkvj1fn1nrf05l5a86aflc5s1p6m-stdenv-linux/setup: line 1766:    47 Aborted                    (core dumped) godot --path . --headless --export-debug "$GODOT_PRESET"
```