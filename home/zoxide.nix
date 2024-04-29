{pkgs,...}:
{
  programs.zoxide = {
    package = [pkgs.zoxide];
    enable = true;
    enableZshIntegration = true;
  };
}