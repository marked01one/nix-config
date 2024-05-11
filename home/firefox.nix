{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    profiles.marked01one = {
      userChrome = '''';
    };
  };
}
