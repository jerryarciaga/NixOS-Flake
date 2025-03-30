{ config, pkgs, ... }:

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
          "layout.css.devPixelsPerPx" = "-1.0";
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
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
