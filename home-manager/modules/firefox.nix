{ config, pkgs, lib, ... }:

let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  # Enable smartcard use
  home.packages = with pkgs; [
    opensc
    ccid
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      name = "default";
      id = 0;
      isDefault = true;
      search = {
        force = true;
        default = "ddg";
        order = [ "ddg" "google" ];
      };
      containersForce = true;
      containers = {
        "1. Personal" = {
          id = 1;
          color = "blue";
          icon = "fingerprint";
        };
        "2. School" = {
          id = 2;
          color = "yellow";
          icon = "briefcase";
        };
        "3. Work" = {
          id = 3;
          color = "turquoise";
          icon = "briefcase";
        };
        "4. Banking" = {
          id = 4;
          color = "red";
          icon = "dollar";
        };
        "5. Shopping" = {
          id = 5;
          color = "orange";
          icon = "cart";
        };
        "6. Social" = {
          id = 6;
          color = "red";
          icon = "pet";
        };
        "7. Gaming" = {
          id = 7;
          color = "red";
          icon = "gift";
        };
        "8. Other" = {
          id = 8;
          color = "red";
          icon = "chill";
        };
      };
    };

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

      # Security Devices
      SecurityDevices.Delete = [
        "Smartcard"
      ];
      SecurityDevices.Add = {
        "Smartcard" = pkgs.opensc + "/lib/opensc-pkcs11.so";
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

      Preferences = { 
          "sidebar.verticalTabs" = lock-true;
          "sidebar.revamp" = lock-true;
          "devtools.toolbox.sidebar.width" = { Value = 1000; Status = "locked"; };
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = lock-true;
          "sidebar.visibility" = { Value = "always-show"; Status = "locked"; };
          "layout.css.devPixelsPerPx" = "-1.0";
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.theme.content-theme" = { Value = 0; Status = "locked"; };
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          # "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "security.insecure_connection_text.enabled" = lock-true;
          "privacy.globalprivacycontrol.enabled" = lock-true;
          # Disable AI Tools
          "browser.ml.enable" = lock-false;
          "browser.ml.chat.enabled" = lock-false;
          "browser.ml.chat.sidebar" = lock-false;
          "browser.ml.chat.shortcuts" = lock-false;
          "browser.ml.chat.shortcuts.custom" = lock-false;
      };
    };
  };
}
