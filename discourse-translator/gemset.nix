{
  aws-eventstream = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0gvdg4yx4p9av2glmp7vsxhs0n8fj1ga9kq2xdb8f95j7b04qhzi";
      type = "gem";
    };
    version = "1.3.0";
  };
  aws-partitions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1qc5dawqk64f7q1m9hs10gjz87g4mhw8nm633hv6ys6lyks1g0dc";
      type = "gem";
    };
    version = "1.1003.0";
  };
  aws-sdk-core = {
    dependencies = ["aws-eventstream" "aws-partitions" "aws-sigv4" "jmespath"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fy8il5fd6cn9184hgm054j42pvphfsdzam6f48m7p9wacnyaddb";
      type = "gem";
    };
    version = "3.212.0";
  };
  aws-sdk-translate = {
    dependencies = ["aws-sdk-core" "aws-sigv4"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1l1dsdpajmwfxgdi7hqwb7ibmcbcsbysj290rwhqknxhl35a5dmx";
      type = "gem";
    };
    version = "1.35.0";
  };
  aws-sigv4 = {
    dependencies = ["aws-eventstream"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1fq3lbvkgm1vk5wa8l7vdnq3vjnlmsnyf4bbd0jq3qadyd9hf54a";
      type = "gem";
    };
    version = "1.10.1";
  };
  jmespath = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1cdw9vw2qly7q7r41s7phnac264rbsdqgj4l0h4nqgbjb157g393";
      type = "gem";
    };
    version = "1.6.2";
  };
}
