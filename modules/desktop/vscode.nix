{pkgs,...}:

{
  programs.vscode= {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };
  environment.systemPackages = with pkgs; [
    nixfmt
  ];
}
