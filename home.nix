{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sigkill";
  home.homeDirectory = "/home/sigkill";
  home.file.".xinitrc" = home.file.".xsession"
  
  xdg.configFile."xmonad" = ./xmonad;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    neovim
    bat
    tree
    htop
    fortune
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xsession = {
    enable = true;
    windowManager.xmonad.enable = true;
  };

  programs = {
    neovim = {
      viAlias = true;
    };
    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.nix-mode
        epkgs.magit
      ];
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
