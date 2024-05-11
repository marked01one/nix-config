{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  home.file.".config/nvim" = {
    source = ./../config/neovim;
    recursive = true;
  };
}
