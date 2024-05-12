{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ":luafile ~/.config/nvim/init.lua";

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  };

  home.file.".config/nvim" = {
    source = ./../config/neovim;
    recursive = true;
  };
}
