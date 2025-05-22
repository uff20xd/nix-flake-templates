{pkgs, modulesPath, ...}: 
{
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
      nixin = "cd ~/nixsetup";
      nixbuild = "sudo nixos-rebuild switch --flake ~/nixsetup --impure";
      homebuild = "home-manager switch --flake ~/nixsetup --impure";
      c = "cd";
      cl = "clear";
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

  isoImage.makeUsbBootable = true;
  isoImage.makeEfiBootable = true;

  environment.systemPackages = with pkgs; [
    git
  ];
}
