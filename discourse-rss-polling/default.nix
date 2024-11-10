{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-rss-polling";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-rss-polling";
    rev = "ae42e81fb2dbbdda96811161640d74cdce7fc26e";
    sha256 = "sha256-jWeQqvuHo2xDJaB9cIjBZ+6AxXzeoIeSnLcP95UNKII========";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}