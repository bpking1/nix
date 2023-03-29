{
  stable = import ./browser.nix {
    channel = "stable";
    version = "109.0.1518.70";
    revision = "1";
    sha256 = "sha256:13h5563sajqx27zjryjxa72ajjmfqqljy5i45fxqmj6yx5phaaiw";
  };
  dev = import ./browser.nix {
    channel = "dev";
    version = "113.0.1741.1";
    revision = "1";
    sha256 = "sha256:0ajnql273frb7sps1m2g4ih82lnxcx07b5h8b8m3k29801npdpym";
  };
  beta = import ./browser.nix {
    channel = "beta";
    version = "92.0.902.9";
    revision = "1";
    sha256 = "sha256:1kba75ms3y9cw8nbvmzd2zqj9f7ri628n7myrjddzq4kid0nglpx";
  };
}