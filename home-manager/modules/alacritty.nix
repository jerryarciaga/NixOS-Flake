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
      window = {
        opacity = 0.90;
        blur = true;
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
