{ pkgs, plugins ? {} }:
let
  customPlugins = pkgs.callPackage ./. { inherit (pkgs.discourse) mkDiscoursePlugin; };
in
with customPlugins;
{
  nixosDiscourse = pkgs.discourse.override {
    plugins = (with pkgs.discourse.plugins; [
      discourse-assign
      discourse-bbcode-color
      discourse-calendar
      discourse-chat-integration
      discourse-data-explorer
      discourse-docs
      discourse-github
      discourse-math
      discourse-openid-connect
      discourse-prometheus
      discourse-saved-searches
      discourse-solved
      discourse-voting
      discourse-yearly-review
    ])
    ++ [
      plugins.discourse-events
      plugins.discourse-templates
    ]);
  };

  bigDiscourse = pkgs.discourse.override {
    plugins = (with pkgs.discourse.plugins; [
      discourse-assign
      discourse-bbcode-color
      discourse-calendar
      discourse-chat-integration
      discourse-data-explorer
      discourse-docs
      discourse-github
      discourse-math
      discourse-openid-connect
      discourse-prometheus
      discourse-saved-searches
      discourse-solved
      discourse-voting
      discourse-yearly-review
    ])
    ++ (with plugins; [
      discourse-events
      discourse-landing-pages
      discourse-question-answer
      discourse-restricted-replies
      discourse-shared-edits
      discourse-templates
      discourse-topic-previews-sidecar
      discourse-user-card-badges
    ]);
  };
}
