{
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0irbdwkkjwzajq1ip6ba46q49sxnrl2cw7ddkdhsfhb6aprnm3vr";
      type = "gem";
    };
    version = "2.8.6";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0skwdasxq7mnlcccn6aqabl7n9r3jd7k19ryzlzzip64cn4x572g";
      type = "gem";
    };
    version = "1.3.3";
  };
  date = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "149jknsq999gnhy865n33fkk22s0r447k76x9pmcnnwldfv2q7wp";
      type = "gem";
    };
    version = "3.3.4";
  };
  excon = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1m3gzvp1wqki0yh4b7761qhdy4pyr4phy429b7s9w25nrkhp4lsz";
      type = "gem";
    };
    version = "0.110.0";
  };
  hashie = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1nh3arcrbz1rc1cr59qm53sdhqm137b258y8rcb4cvd3y98lwv4x";
      type = "gem";
    };
    version = "5.0.0";
  };
  icalendar = {
    dependencies = ["ice_cube"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "11zfs0l8y2a6gpf0krm91d0ap2mnf04qky89dyzxwaspqxqgj174";
      type = "gem";
    };
    version = "2.8.0";
  };
  icalendar-recurrence = {
    dependencies = ["icalendar" "ice_cube"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06li3cdbwkd9y2sadjlbwj54blqdaa056yx338s4ddfxywrngigh";
      type = "gem";
    };
    version = "1.1.3";
  };
  ice_cube = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1dri4mcya1fwzrr9nzic8hj1jr28a2szjag63f9k7p2bw9fpw4fs";
      type = "gem";
    };
    version = "0.16.4";
  };
  iso-639 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1k1r8wgk6syvpsl3j5qfh5az5w4zdvk0pvpjl7qspznfdbp2mn71";
      type = "gem";
    };
    version = "0.3.5";
  };
  omnievent = {
    dependencies = ["hashie" "iso-639" "tzinfo"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0imd8nbqx0c0jnypdrmn1ay935jjdd7ylg18c1fhz13ci26r4ps9";
      type = "gem";
    };
    version = "0.1.0.pre3";
  };
  omnievent-api = {
    dependencies = ["excon" "omnievent"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0i8r8pmq0kcjyw4m337rdk0lg1xj0fda455wppks4m82chv1220i";
      type = "gem";
    };
    version = "0.1.0.pre2";
  };
  omnievent-eventbrite = {
    dependencies = ["omnievent" "omnievent-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "019zmqgmmbmkl25c74rd9yl3mf76v78ndg3bi1l65kx1kvr0iipm";
      type = "gem";
    };
    version = "0.1.0.pre2";
  };
  omnievent-eventzilla = {
    dependencies = ["omnievent" "omnievent-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1x2irk6814h42axmfzhcxsh46jplphl8qvzgd3374ccxwkqih6mp";
      type = "gem";
    };
    version = "0.1.0.pre2";
  };
  omnievent-icalendar = {
    dependencies = ["addressable" "icalendar" "icalendar-recurrence" "omnievent"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "06wq33q2m8xfnz8i29xhwgnrp4d1swpq2si9qqkyjkqiyxq5xsk0";
      type = "gem";
    };
    version = "0.1.0.pre5";
  };
  omnievent-meetup = {
    dependencies = ["omnievent" "omnievent-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "12fdfg154wvwqgz3174wflyk2q5qsivbbcizgiqrwj5dzqz7kb6f";
      type = "gem";
    };
    version = "0.1.0.pre1";
  };
  public_suffix = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1vb6f3v8q9m67xmbdl4vbmxis53a7igci4blg561jdfp613cf3i5";
      type = "gem";
    };
    version = "5.1.1";
  };
  stringio = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0ix96dxbjqlpymdigb4diwrifr0bq7qhsrng95fkkp18av326nqk";
      type = "gem";
    };
    version = "3.0.8";
  };
  time = {
    dependencies = ["date"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1p8aplbgzmfbaax9aky9wypavj1y8gx4ml468nz7js0dg867d25k";
      type = "gem";
    };
    version = "0.2.0";
  };
  tzinfo = {
    dependencies = ["concurrent-ruby"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "16w2g84dzaf3z13gxyzlzbf748kylk5bdgg3n1ipvkvvqy685bwd";
      type = "gem";
    };
    version = "2.0.6";
  };
  uuidtools = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0s8h35ia80p919kidb66nfp8904rhdmn41z9ghsx4ihp2ild3bn4";
      type = "gem";
    };
    version = "2.2.0";
  };
}
