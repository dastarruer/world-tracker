{pkgs, ...}: {
  # https://devenv.sh/languages/
  languages = {
    javascript = {
      enable = true;
      npm.enable = true;
    };
    typescript.enable = true;
  };

  # https://devenv.sh/packages/
  packages = [
    pkgs.docker
    pkgs.docker-compose
  ];

  # See full reference at https://devenv.sh/reference/options/
}
