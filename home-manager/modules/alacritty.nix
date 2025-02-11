{ config, pkgs, ... }:

{

  programs.alacritty = {
    enable = true;
    settings = {
      hints.enabled = [
        {
          command = "None";
          post_processing = true;
          regex = "(ipfs:|ipns:|magnet:|mailto:|gemini:|gopher:|https:|http:|news:|file:|git:|ssh:|ftp:)[^\\u0000-\\u001F\\u007F-<9f><>\"\\\\s{-}\\\\^⟨⟩`]+";
        }
      ];
      selection = {
        semantic_escape_chars = ",`|\"'()[]{}<>\t";
      };
      window = {
        opacity = 0.9;
        blur = true;
        padding.x = 10;
        padding.y = 10;
        decorations = "Full";
      };
      colors = {
        transparent_background_colors = true;
      };
      font = {
        normal.family = "Cascadia Code PL";
        bold.family = "Cascadia Code PL";
        italic.family = "Cascadia Code PL";
        bold_italic.family = "Cascadia Code PL";
        size = 12.0;
      };
      keyboard.bindings = [
        {
          action = "SpawnNewInstance";
          key = "Return";
          mods = "Control|Shift";
        }
      ];
    };
  };

}
