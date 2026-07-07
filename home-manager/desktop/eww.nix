{ ... }:

{

  programs.eww = {
    enable = true;
    yuckConfig = builtins.readFile ./config/eww/eww.yuck;
    scssConfig = builtins.readFile ./config/eww/eww.scss;
  };

}
