{...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file."./config/nvim" = {
    source = ./../config/neovim;
    recursive = true;
  };
}
