{pkgs, ...}:
{
  programs.zsh.enable = true;

  home.file = {
    ".zshrc".source = ./home/zsh/.zshrc;
  };
}