{
  config,
  pkgs,
  lib,
  ...
}: {
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
    # Nix
    alejandra.enable = true;

    # Typescript
    eslint.enable = true;

    svelte-check = {
      name = "svelte-check";
      entry = "${lib.getExe pkgs.svelte-check} --fail-on-warnings --workspace ${config.git.root}/app --tsconfig ${config.git.root}/app/tsconfig.json";
      files = "\\.svelte$";
    };

    # Everything else basically
    # Override the default git hook to lint .svelte files as well
    # This refuses to work, disabling for now
    # prettier = {
    #   enable = true;
    #   entry = "${config.git.root}/app/node_modules/.bin/prettier --write --plugin=prettier-plugin-svelte";
    #   files = "\\.(js|ts|svelte|css|html)$";
    # };
  };

  # Run the sveltekit server
  processes = {
    app = {
      cwd = "./app";
      exec = "npm run dev";
    };
  };
}
