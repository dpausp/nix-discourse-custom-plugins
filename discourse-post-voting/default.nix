{ lib, mkDiscoursePlugin, fetchFromGitHub }:

mkDiscoursePlugin {
  name = "discourse-post-voting";
  src = fetchFromGitHub {
    owner = "discourse";
    repo = "discourse-post-voting";
    rev = "51c1eda2b99c245362ce6226c1011b661c27196a";
    sha256 = "sha256-6ow5L9poFa8Tq+d6usfgHz9QjAt1Z28g41sIEiN/+0Q==";
};
  meta = with lib; {
    homepage = "";
    maintainers = with maintainers; [ ];
    license = licenses.mit; # change to the correct license!
    description = "";
  };
}
