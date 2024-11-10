{
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0cl2qpvwiffym62z991ynks7imsm87qmgxf0yfsmlwzkgi9qcaa6";
      type = "gem";
    };
    version = "2.8.7";
  };
  concurrent-ruby = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0chwfdq2a6kbj6xz9l6zrdfnyghnh32si82la1dnpa5h75ir5anl";
      type = "gem";
    };
    version = "1.3.4";
  };
  date = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "04d7l3xdmkybrd20gayf8s38pgfld0hf8m726lz9np32xnnsszrf";
      type = "gem";
    };
    version = "3.4.0";
  };
  excon = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1ra8msr3flnx7z1b99jpxivy8xygp2azh02nm20m5ld8fsm3hvyg";
      type = "gem";
    };
    version = "1.2.0";
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
      sha256 = "046ai8k851flnb69d2mlsk89ripr0iirpzb19vb2fr3a3fs3rlla";
      type = "gem";
    };
    version = "0.1.0.pre7";
  };
  omnievent-api = {
    dependencies = ["excon" "omnievent"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a87wybyif1z8nb5hirzgfph7m81igzqfvy2bh3mg1hfw6y6j6xr";
      type = "gem";
    };
    version = "0.1.0.pre4";
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
  omnievent-google = {
    dependencies = ["omnievent" "omnievent-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "015zh7jhs9y4a2h9rj2v9w0790z31h96qm0wdacxcr38nl5q8cbk";
      type = "gem";
    };
    version = "0.1.0.pre4";
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
  omnievent-outlook = {
    dependencies = ["omnievent" "omnievent-api"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "075qmpkppzpja43wjdjr4clbc3jqwrw42j8hf66a6wngq4ynrp5y";
      type = "gem";
    };
    version = "0.1.0.pre7";
  };
  public_suffix = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0vqcw3iwby3yc6avs1vb3gfd0vcp2v7q310665dvxfswmcf4xm31";
      type = "gem";
    };
    version = "6.0.1";
  };
  stringio = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07mfqb40b2wh53k33h91zva78f9zwcdnl85jiq74wnaw2wa6wiak";
      type = "gem";
    };
    version = "3.1.1";
  };
  time = {
    dependencies = ["date"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "13pzdsgf3v06mymzipcpa7p80shyw328ybn775nzpnhc6n8y9g30";
      type = "gem";
    };
    version = "0.2.2";
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
