{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    autorestic
  ];

  home.file = {
    ".autorestic.yml" = {
      enable = true;
      source = config/autorestic/autorestic.yml;
      target = ".autorestic.yml";
    };
  };

  systemd.user.services = {
    autorestic = {
      Unit = {
        Description = "Run Autorestic backup";
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.autorestic}/bin/autorestic backup --ci --all --config=/home/cell/.autorestic.yml";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };

  systemd.user.timers = {
    autorestic = {
      Unit = {
        Description = "Run Autorestic backup";
      };

      Timer = {
        Unit = "%i.service";
        OnBootSec = "10min";
        OnUnitActiveSec = "1d";
      };

      Install = {
        WantedBy = ["default.target"];
      };
    };
  };
}
