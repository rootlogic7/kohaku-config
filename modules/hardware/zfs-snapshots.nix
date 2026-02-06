{ config, pkgs, ... }:

{
  # --- ZFS Snapshot Automatisierung (Sanoid) ---
  services.sanoid = {
    enable = true;
    interval = "minutely";

    templates = {
      default = {
        hourly = 24;
        daily = 7;
        monthly = 2;
        autoprune = true;
        autosnap = true;
      };
    };
    # Zu sichernde Datasets
    datasets = {
      # System & Home
      "rpool/home" = { use_template = [ "default" ]; };
      "rpool/root" = { use_template = [ "default" ]; };
    };
  };
  # Automatisches Scrubbing (Daten-Integritätsprüfung)
  services.zfs.autoScrub = {
    enable = true;
    interval = "weekly";
  };
}
