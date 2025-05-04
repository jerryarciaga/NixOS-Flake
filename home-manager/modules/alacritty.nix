{ lib, pkgs, ... }:

{

  catppuccin.alacritty = {
    enable = true;
    flavor = "mocha";
  };

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
        opacity = lib.mkForce 0.9;
        blur = lib.mkForce true;
        padding.x = lib.mkForce 10;
        padding.y = lib.mkForce 10;
        decorations = lib.mkForce "Full";
      };
      colors = {
        transparent_background_colors = true;
      };
      font = {
        normal.family = lib.mkForce "Cascadia Code PL";
        bold.family = lib.mkForce "Cascadia Code PL";
        italic.family = lib.mkForce "Cascadia Code PL";
        bold_italic.family = lib.mkForce "Cascadia Code PL";
        size = lib.mkForce 12.0;
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
