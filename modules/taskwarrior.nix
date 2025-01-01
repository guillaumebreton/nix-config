

{  ...}:

{
  xdg.configFile."taskwarrior-theme" = {
      source = ../config/.task.theme;
      target = "taskwarrior/.task.theme";
  };

  xdg.configFile."taskwarrior-config" = {
      source = ../config/.taskrc;
      target = "taskwarrior/.taskrc";
  };
}
