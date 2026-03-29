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
      cd "${config.git.root}/app"
      # npx ensures we use the local version in /app/node_modules
      npx eslint . --fix
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
      cd "${config.git.root}/app"
      npm run format
    '';
  };
in {
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
      files = "\\.(js|ts|svelte)$";
    };

    svelte-check = {
      name = "svelte-check";
      entry = "${lib.getExe svelte-check}";
      files = "\\.svelte$";
    };

    npm-format = {
      enable = true;
      name = "npm-format";
      entry = "${lib.getExe npm-format}";
      files = "\\.(js|ts|json|svelte|md|css|html)$";
      pass_filenames = false;
    };
  };

  processes = {
    app = {
      exec = "npm run dev";
      cwd = "${config.git.root}/app";
    };
  };
}
