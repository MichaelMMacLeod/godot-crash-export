{
  description = "Game development flake";

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
        rustPkg = pkgs.rustPlatform.buildRustPackage pkgConfi;
      in
      {
        packages = {
          x86_64-linux-full3 = pkgs.stdenv.mkDerivation {
            name = "x86_64-linux-full";
            system = system;
            src = ./godot;

            meta.mainProgram = "Game.x86_64";

            nativeBuildInputs = with pkgs; [
              autoPatchelfHook
              breakpointHook
              glibc
            ];

            buildInputs = with pkgs; [
              makeWrapper
              rustPkg
              godotPackages_4_5.godot
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

            GODOT_VERSION_DIR = "4.5.1.stable";
            GODOT_EXPORT_TEMPLATES_DIR = "${pkgs.godotPackages_4_5.export-templates-bin.out}/share/godot/export_templates/";
            GAME_SHARED_LIBRARY_OUT = "${linuxRustPkg.out}";
            GODOT_PRESET = "Linux";
            FONTCONFIG_FILE = "${pkgs.fontconfig.out}/etc/fonts/fonts.conf";
            FONTCONFIG_PATH = "${pkgs.fontconfig.out}/etc/fonts";

            buildPhase = builtins.readFile ./scripts/buildPhase.sh;
            installPhase = builtins.readFile ./scripts/installPhase.sh;
          };
        };
      }
    );
}
