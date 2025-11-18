{
  description = "Test development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgConfig = {
          pname = "librust";
          version = "0.1.0";
          src = ./rust;
          cargoLock.lockFile = ./rust/Cargo.lock;
        };
        rustPkg = pkgs.rustPlatform.buildRustPackage pkgConfig;
        godotVersion = builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot.version;
      in
      {
        packages = {
          test = pkgs.stdenv.mkDerivation {
            name = "x86_64-linux-full";
            system = system;
            src = ./godot;

            meta.mainProgram = "TestProject.x86_64";

            nativeBuildInputs = with pkgs; [
              autoPatchelfHook
              glibc
            ];

            buildInputs = with pkgs; [
              makeWrapper
              rustPkg
              godot
            ];

            runtimeDependencies = with pkgs; [
              vulkan-loader
              libGL
              xorg.libX11
              xorg.libXcursor
              xorg.libXinerama
              xorg.libXext
              xorg.libXrandr
              xorg.libXrender
              xorg.libXi
              xorg.libXfixes
              libxkbcommon
              alsa-lib
              fontconfig.lib
              dbus.lib
              pulseaudio.out
            ];

            GODOT_VERSION = "${godotVersion}";
            GODOT_EXPORT_TEMPLATES_NIX_DIR = "${pkgs.godotPackages.export-templates-bin.out}/share/godot/export_templates";
            GODOT_EXPORT_TEMPLATES_LOCAL_DIR = ".local/share/godot/export_templates";

            GAME_SHARED_LIBRARY_OUT = "${rustPkg.out}";
            GODOT_PRESET = "Linux";
            FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";

            buildPhase = builtins.readFile ./scripts/buildPhase.sh;
            installPhase = builtins.readFile ./scripts/installPhase.sh;
          };
        };
      }
    );
}
