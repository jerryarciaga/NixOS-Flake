{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
    pavucontrol
  ];
}
