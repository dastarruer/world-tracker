{
  config,
  pkgs,
  lib,
  ...
}: let
  eslint = pkgs.writeShellApplication {
    name = "eslint-wrapper";
    runtimeInputs = [pkgs.nodejs_latest];
    text = ''
      # Skip the hook if no relevant files are staged
      if [ "$#" -eq 0 ]; then
        exit 0
      fi

      cd "${config.git.root}"
      # npx ensures we use the local version in /app/node_modules
      npx --prefix app eslint --fix "$@"
    '';
  };
  svelte-check = pkgs.writeShellApplication {
    name = "svelte-format";
    runtimeInputs = [pkgs.svelte-check];
    text = ''
      svelte-check --fail-on-warnings --workspace ${config.git.root}/app --tsconfig ${config.git.root}/app/tsconfig.json
    '';
  };
  npm-format = pkgs.writeShellApplication {
    name = "npm-format";
    runtimeInputs = [pkgs.nodejs_latest];
    text = ''
      # Skip the hook if no relevant files are staged
      if [ "$#" -eq 0 ]; then
        exit 0
      fi

      cd "${config.git.root}/app"

      # Remove the "app/" prefix from filenames before passing to prettier, since prettier is being run in the /app directory anyways
      npx prettier --write "''${@#app/}"
    '';
  };
in {
  # Disable on macos to prevent build issues
  cachix.enable = !pkgs.stdenv.isDarwin;

  packages = [
    pkgs.ktx-tools
  ];

  # https://devenv.sh/languages/
  languages = {
    javascript = {
      enable = true;
      npm.enable = true;
      # Necessary to define for the app process to work; otherwise nodejs is not available in the process
      package = pkgs.nodejs_latest;
    };
    typescript.enable = true;
  };

  git-hooks.hooks = {
    alejandra.enable = true;

    eslint = {
      name = "eslint";
      entry = "${lib.getExe eslint}";
      files = "^app/.*\\.(js|ts|svelte)$";
      pass_filenames = true;
    };

    svelte-check = {
      name = "svelte-check";
      entry = "${lib.getExe svelte-check}";
      files = "\\.svelte$";
      pass_filenames = false;
    };

    npm-format = {
      enable = true;
      name = "npm-format";
      entry = "${lib.getExe npm-format}";
      # Only run prettier on files in the /app directory
      files = "^app/.*\\.(js|ts|json|svelte|md|css|html)$";
      pass_filenames = true;
    };
  };

  processes = {
    app = {
      exec = "npm run dev";
      cwd = "${config.git.root}/app";
    };
  };

  enterTest = ''
    node --version | grep -Fx "v${pkgs.nodejs_latest.version}"
  '';
}
