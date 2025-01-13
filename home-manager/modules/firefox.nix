{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    policies = {
      # Telemetry and tracking protection
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };

      # Autofill
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      # Addons
      DisablePocket = true;
      DisplayBookmarksToolbar = "always";
      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
        Locked = true;
      };
      HardwareAcceleration = true;

      # Logins and password management
      PasswordManagerEnabled = false;
      OfferToSaveLoginsDefault = false;

      # Permissions
      Permissions = {
        Autoplay = {
          Default = "block-audio-video";
        };
      };
    };
  };
}
