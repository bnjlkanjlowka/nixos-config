{ ... }:

{
  services.unbound = {
    enable = true;
    settings = {
      port = 5353;
    };
  };
}
