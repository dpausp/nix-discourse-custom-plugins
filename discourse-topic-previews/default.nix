{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-topic-previews";
  src = fetchFromGitHub {
    owner = "merefield";
    repo = "discourse-topic-previews";
    rev = "971ba5d3a868506b34b61201c32640a0a6bbaa01";
    sha256 = "10bmrz0jq1jc8lqr5p1dm67sjhvzhhvkray60am633a0vvza9icy";
  };
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}