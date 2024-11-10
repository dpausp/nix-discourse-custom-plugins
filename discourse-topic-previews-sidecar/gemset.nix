{
  observer = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1b2h1642jy1xrgyakyzz6bkq43gwp8yvxrs8sww12rms65qi18yq";
      type = "gem";
    };
    version = "0.1.2";
  };
  pkg-config = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04wi7n51w42v9s958gfmxwkg5iikq25whacyflpi307517ymlaya";
      type = "gem";
    };
    version = "1.5.6";
  };
  prizm = {
    dependencies = ["rmagick"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1xcziygp8q6xsrliaswsn5bsqnqfc34wrifh36wndar1qdzpbdsc";
      type = "gem";
    };
    version = "0.0.3";
  };
  rmagick = {
    dependencies = ["observer" "pkg-config"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0qa11i72j76q2v8lbvls3a8dqvkh9v3sgbd9mv9g2rqvb8gqkjrp";
      type = "gem";
    };
    version = "6.0.1";
  };
}
