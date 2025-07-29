{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-new-plugin";
  src = fetchFromGitHub {
    owner = "your-username";
    repo = "discourse-new-plugin";
    rev = "replace-with-git-rev";
    sha256 = "replace-with-sha256";
  };
  meta = with lib; {
    description = "Description of your new plugin";
    homepage = "https://github.com/your-username/discourse-new-plugin";
    license = licenses.mit;
    maintainers = [ maintainers.your-name ];
  };
}