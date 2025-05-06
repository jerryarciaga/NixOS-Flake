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

  # Bluetooth configuration
  # See https://nixos.wiki/wiki/PipeWire#Bluetooth_Configuration
  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    };
  };
}
