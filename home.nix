{
  config,
  pkgs,
  ...
}: {
  # This is the "Fix everything on non-NixOS" switch
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    # Sometimes required as a workaround for specific Home Manager bugs:
    allowUnfreePredicate = _: true;
  };

  targets.genericLinux.enable = true;
  targets.genericLinux.gpu.enable = true;
  targets.genericLinux.gpu.nvidia = {
    enable = true;
    version = "570.153.02";
    sha256 = "sha256-FIiG5PaVdvqPpnFA5uXdblH5Cy7HSmXxp6czTfpd4bY=";
  };
  xdg.enable = true;

  home.username = "vadim";
  home.homeDirectory = "/home/vadim";

  home.shellAliases = {
    hms = "home-manager switch";
    hme = "zed ~/.config/home-manager";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.golangci-lint # golang linter
    pkgs.alejandra # nix formatter
    pkgs.nixd # nix lsp
    pkgs.bat # cat
    pkgs.eza # ls
    pkgs.fd # find
    pkgs.devenv
    pkgs.codex
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/ghostty/config".source = config/ghostty/config;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vadim/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "zed";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };

  # programs.bash = {
  #   enable = true;
  #   historyControl = ["ignoredups" "ignorespace"];
  #   initExtra = builtins.readFile ./programs/bash/.bashrc;
  # };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initContent = builtins.readFile ./programs/zsh/.zshrc;
    dotDir = "${config.xdg.configHome}/zsh";

    history.size = 10000;
    history.ignoreAllDups = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # programs.fish = {
  #   enable = true;
  #   interactiveShellInit = builtins.readFile ./programs/fish/fish.config;
  # };

  # programs.nushell = {
  #   enable = true;
  #   configFile.source = ./programs/nushell/config.nu;
  # };

  programs.git = {
    enable = true;
    settings.user = {
      name = "Vadim Vorotilov";
      email = "vorotilov.vadim@gmail.com";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.go = {
    enable = true;
  };
}
