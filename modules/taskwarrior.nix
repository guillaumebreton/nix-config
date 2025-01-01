

{  ...}:

{
  xdg.configFile."taskwarrior-theme" = {
      source = ../config/.task.theme;
      target = ".task.theme";
  };

  xdg.configFile."taskwarrior-config" = {
      source = ../config/.taskrc;
      target = ".taskrc";
  };
}
