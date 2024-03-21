{
  description = "TS Spect Compiler";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        pythonPackages = with pkgs.python310Packages; [
          venvShellHook
          jinja2
        ];
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            cmake
            clang
            python310
            libxslt
          ] ++ pythonPackages;

          # TS_REPO_ROOT = builtins.getEnv "PWD"; # unrelable way how to determine the project root path
          venvDir = ".virt";
          postVenvCreation = ''
            unset SOURCE_DATE_EPOCH
            pip install --upgrade pip
            pip install wheel
            pip install --requirement requirements.txt
          '';

          shellHook = ''
            export PATH=$PATH:/home/qup/projects/ts-spect-compiler/build/src/apps;
            export TS_REPO_ROOT=`pwd`;
          '';

        };
      }
    );
}
