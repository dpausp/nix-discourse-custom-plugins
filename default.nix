{ mkDiscoursePlugin, newScope, fetchFromGitHub, ... }@args:
let
  callPackage = newScope args;
in
{
  discourse-chat = callPackage ./discourse-chat {};
  discourse-landing-pages = callPackage ./discourse-landing-pages {};
  discourse-question-answer = callPackage ./discourse-question-answer {};
  discourse-restricted-replies = callPackage ./discourse-restricted-replies {};
  discourse-rss-polling = callPackage ./discourse-rss-polling {};
  discourse-shared-edits = callPackage ./discourse-shared-edits {};
  discourse-topic-previews-sidecar = callPackage ./discourse-topic-previews-sidecar {};
  discourse-translator = callPackage ./discourse-translator {};
  discourse-user-card-badges = callPackage ./discourse-user-card-badges {};
}
