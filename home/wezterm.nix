{pkgs,...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/wezterm" = {
    source = ./../config/wezterm;
    recursive = true;
  };
}