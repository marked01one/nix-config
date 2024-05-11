{pkgs, ...}: {
  programs.zsh.enable = true;

  home.file = {
    ".zshrc".source = ./../config/zsh/.zshrc;
  };
}
