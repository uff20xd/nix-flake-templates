{pkgs, modulesPath, ...}: 
{

  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader.grub.enable = true;
  boot.loader.grup.efiSupport = true;
  boot.loader.grub.device = "/dev/sda";

  console.keyMap = "de";

  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "skaro";
    };
    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gf = "git fetch";
      gcl = "git clone";
      nixin = "cd ~/nixsetup";
      nixbuild = "sudo nixos-rebuild switch --flake ~/nixsetup --impure";
      homebuild = "home-manager switch --flake ~/nixsetup --impure";
      c = "cd";
      cl = "clear";
      nsh = "nix shell";
    };
  };

  services.xserver.xkb = {
    layout = "de";
    options = "caps:swapescape";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  nix.settings = {
    show-trace = true;

    system-features = [ "big-parallel" "kvm" "recursive-nix" ];
    sandbox-paths = [ "/bin/sh=${pkgs.busybox-sandbox-shell.out}/bin/busybox" ];

    experimental-features = ["nix-command flakes"];
  };

  environment.systemPackages = with pkgs; [
    git
  ];
}
