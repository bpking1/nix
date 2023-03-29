{
  programs = {
    git = {
      enable = true;
      userName = "bpking";
      userEmail = "yihe.hejie@gmail.com";
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      # signing = {
      #   # key = "18B9F11F26C894A0D9E3F92BB26EAEB7189F30B4";
      #   signByDefault = false;
      # };
      # extraConfig = {
      #   url = {
      #     "ssh://git@github.com:bpking1" = {
      #       insteadOf = "https://github.com/bpking1/";
      #     };
      #   };
      # };
    };
  };
}
