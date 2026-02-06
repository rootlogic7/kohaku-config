{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    
    # Experimentelle Beta-Treiber aus dem Kernel-Package (Chaotic/Unstable)
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    
    # Open Source Kernel Module (besser für Wayland/neue GPUs)
    open = true;
    
    nvidiaSettings = true;
    
    powerManagement = {
      enable = true;
      finegrained = false; 
    };
  };

  # Wayland Environment Variables für Nvidia
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; 
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
  
  # Kernel Parameter für Framebuffer
  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];
}
