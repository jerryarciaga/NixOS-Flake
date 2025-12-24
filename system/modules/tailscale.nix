{ ... }:

{
  services.tailscale = {
    enable = true;
    extraSetFlags = ["--netfilter-mode=nodivert"];
    extraDaemonFlags = ["--no-logs-no-support"];
  };
}
