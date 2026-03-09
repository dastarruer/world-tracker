{pkgs, ...}: {
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

  # https://devenv.sh/packages/
  packages = [
    pkgs.docker
    pkgs.docker-compose
  ];

  # Run the sveltekit server
  processes = {
    app = {
      cwd = "./app";
      exec = "npm run dev";
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}
