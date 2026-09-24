{ ... }:

{
  #If you are on an AMD GPU, it is recommended to enable overdrive mode by using hardware.amdgpu.overdrive.enable = true; in your configuration. See LACT wiki for more information.
  hardware.amdgpu.overdrive.enable = true;

  services.lact = {
    enable = true;
    settings = {
      version = 7;
      daemon = {
        log_level = "info";
        admin_group = "wheel";
        disable_clocks_cleanup = false;
      };
      apply_settings_timer = 5;
      gpus = {
        "1002:7550-1DA2:E490-0000:03:00.0" = {
          fan_control_enabled = false;
          pmfw_options = {
            zero_rpm = true;
          };
          power_cap = 280.0;
          perfomance_level = "auto";
          gpu_clock_offsets = {
            "0" = -50;
          };
          voltage_offset = -50;
        };
      };
      current_profile = null;
      auto_switch_profiles = false;
    };
  };
}
