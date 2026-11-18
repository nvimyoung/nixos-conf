{ pkgs, lib, ... }:
let
  addon =
    name: addonId: url: hash:
    pkgs.runCommand "firefox-addon-${name}"
      {
        passthru.addonId = addonId;
        src = pkgs.fetchurl { inherit url hash; };
      }
      ''
        install -Dm644 "$src" \
          "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/${addonId}.xpi"
      '';

  disabledPrefs = [
    # Telemetry, studies and crash reporting
    "app.normandy.enabled"
    "app.shield.optoutstudies.enabled"
    "datareporting.healthreport.uploadEnabled"
    "datareporting.policy.dataSubmissionEnabled"
    "toolkit.telemetry.enabled"
    "toolkit.telemetry.unified"
    "toolkit.telemetry.archive.enabled"
    "toolkit.telemetry.newProfilePing.enabled"
    "toolkit.telemetry.shutdownPingSender.enabled"
    "toolkit.telemetry.firstShutdownPing.enabled"
    "toolkit.telemetry.bhrPing.enabled"
    "toolkit.telemetry.updatePing.enabled"
    "toolkit.coverage.enabled"
    "browser.ping-centre.telemetry"
    "browser.newtabpage.activity-stream.telemetry"
    "browser.newtabpage.activity-stream.feeds.telemetry"
    "browser.newtabpage.activity-stream.telemetry.privatePing.enabled"
    "browser.urlbar.eventTelemetry.enabled"
    "browser.tabs.crashReporting.sendReport"
    "browser.crashReports.unsubmittedCheck.autoSubmit2"
    "security.ssl.errorReporting.enabled"
    "beacon.enabled"

    # AI features
    "browser.ml.enable"
    "browser.ml.chat.enabled"
    "browser.ml.chat.menu"
    "browser.ml.chat.page"
    "browser.ml.chat.shortcuts"
    "browser.ml.chat.sidebar"
    "browser.ml.linkPreview.enabled"
    "browser.ml.pageAssist.enabled"
    "browser.tabs.groups.smart.enabled"
    "browser.tabs.groups.smart.userEnabled"
    "browser.smartwindow.enabled"
    "browser.smartwindow.autoTabGrouping.enabled"
    "browser.smartwindow.autoTabGrouping.preloadModels"
    "browser.smartwindow.smartformfill.enabled"
    "browser.smartwindow.agent.enabled"
    "browser.smartwindow.agent.toolbar.enabled"
    "browser.smartwindow.memories.generateFromHistory"
    "browser.smartwindow.memories.generateFromConversation"
    "browser.smartwindow.searchTheWebFast"
    "places.semanticHistory.smartwindow.featureGate"
  ];
in
{
  # Firefox created this before Home Manager managed the profile.
  home.file.".config/mozilla/firefox/profiles.ini".force = true;

  # Firefox under Wayland (MOZ_ENABLE_WAYLAND is set in home.nix).
  programs.firefox = {
    enable = true;

    profiles.main = {
      id = 0;
      isDefault = true;

      settings = (lib.genAttrs disabledPrefs (_: false)) // {
        "breakpad.reportURL" = "";

        # Enable profile-installed extensions.
        "extensions.autoDisableScopes" = 0;
        "extensions.enabledScopes" = 15;

        # Dark theme by default.
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "browser.theme.toolbar-theme" = 0;
        "browser.theme.content-theme" = 0;
        "layout.css.prefers-color-scheme.content-override" = 0;

        # Keep extension buttons in the extensions panel, not on the toolbar.
        "browser.uiCustomization.state" = builtins.toJSON {
          placements.unified-extensions-area = [
            "addon_darkreader_org-browser-action"
            "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
            "ublock0_raymondhill_net-browser-action"
          ];
          currentVersion = 28;
        };
      };

      extensions.packages = [
        (addon "ublock-origin" "uBlock0@raymondhill.net"
          "https://addons.mozilla.org/firefox/downloads/file/5257481/ublock_origin-1.76.4.xpi"
          "sha256-ZtDj8hzjsysbwKk5m5PLLJqlmO8YgF2SEYx29m4mbB4="
        )
        (addon "dark-reader" "addon@darkreader.org"
          "https://addons.mozilla.org/firefox/downloads/file/5216111/darkreader-4.9.135.xpi"
          "sha256-v+1FkdbMaYV/XtM6LTy/vFgR1bksQyPQc10vF1fi3OQ="
        )
        (addon "privacy-badger" "jid1-MnnxcxisBPnSXQ@jetpack"
          "https://addons.mozilla.org/firefox/downloads/file/5032646/privacy_badger17-2026.9.15.xpi"
          "sha256-l82JEeNIbaNKUyp8fygGzW0M+hF6H75eh0cEKpRELWI="
        )
      ];
    };
  };
}
