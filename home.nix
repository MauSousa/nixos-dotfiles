{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = ""; # Change this to your user
  home.homeDirectory = "";   # Change this to your home directory

  services.network-manager-applet.enable = true;
  services.playerctld.enable = true;
  services.flameshot.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.wlrobs ];
  };

  # For now creating ssh and gpg keys are done manually
  programs.git = {
    enable = true;
    settings = {
      user.name = "";
      user.email = "";
      user.signingkey = "";
      init.defaultBranch = "main";
      core.editor = "hx";
      commit.gpgsign = true;
      tag.gpgSign = true;
      alias = {
        lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(blue)%s%C(reset) %C(bold red)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        s = "status -s -b";
      };
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      clare = "clear";
      clear = "clear";
      claer = "clear";
      clera = "clear";
      lg = "lazygit";
      ls = "eza --icons -lAh --group-directories-first";
      rebb = "sudo nixos-rebuild boot --flake /etc/nixos#nixstation";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixstation";
      nx = "sudo hx /etc/nixos/configuration.nix";
      hnx = "sudo hx /etc/nixos/home.nix";
      rm = "rm -v";
      pest = "./vendor/bin/pest";
      pestp = "./vendor/bin/pest --parallel";
      ild = "install-laravel-dependencies";
      format = "composer format";
      analyze = "composer analyse";
    };
    bashrcExtra = ''
      fastfetch
    '';
    profileExtra = ''
      [ "$(tty)" = "/dev/tty1" ] && exec sway
    '';
  };

  programs.zoxide.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };


  xdg.configFile."starship.toml".source = ./starship/starship.toml;
  programs.starship = {
    enable = true;
  };

  home.pointerCursor = {
    x11.enable = true; # For X11 sessions
    package = pkgs.breeze-hacked-cursor-theme; # e.g., pkgs.bibata-cursors
    name = "Breeze_Hacked"; # e.g., "Bibata-Modern-Classic"
    size = 5; # Optional size setting
  };
  
  gtk = {
    enable = true; # Enable general GTK theming
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine-moon";
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-moon";
    };
  };

  # Swayand Swaylock
  xdg.configFile."sway/config".source = ./sway/config;
  xdg.configFile."sway/outputs".source = ./sway/outputs;

  # Waybar 
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."waybar/scripts/mediaplayer.py".source = ./waybar/scripts/mediaplayer.py;
  
  # Swaylock
  xdg.configFile."swaylock/config".source = ./swaylock/config;

  # Wofi
  xdg.configFile."wofi/config".source = ./wofi/config;
  xdg.configFile."wofi/style.css".source = ./wofi/style.css;

  # Ghostty
  xdg.configFile."ghostty/config".source = ./ghostty/config;

  # Helix
  xdg.configFile."helix/config.toml".source = ./helix/config.toml;
  xdg.configFile."helix/languages.toml".source = ./helix/languages.toml;

  # Fastfetch
  xdg.configFile."fastfetch/config.jsonc".source = ./fastfetch/config.jsonc;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    alacritty
    bat
    brave
    bun
    cava
    clipse
    curl
    eza
    fastfetch
    fd
    file
    firefox-devedition
    font-awesome
    fzf
    gcc
    ghostty
    gobject-introspection
    grim
    gtk3
    helix
    imv
    jq
    killall
    laravel
    lazygit
    libgcc
    lldb
    macchina
    markdown-oxide
    marksman
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nodejs_24
    nodePackages.typescript
    nodePackages.typescript-language-server
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    nwg-displays
    nwg-look
    pavucontrol
    php
    php84Packages.composer
    php84Extensions.xdebug
    playerctl
    prettier
    pnpm
    python315
    ripgrep
    rocmPackages.llvm.llvm
    tailwindcss-language-server
    taplo
    slurp
    swaynotificationcenter
    sway-contrib.grimshot
    uv
    vesktop
    vscode-langservers-extracted
    vue
    vue-language-server
    waybar
    wl-clipboard
    wofi
    xdg-user-dirs
    xfce.thunar
    yaml-language-server
    zig
    zls

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # Face icon
    ".face".source = ./.face;

    # Laravel related stuff
    ".local/bin/install-laravel-dependencies".source = ./laravel-scripts/install-laravel-dependencies;
    ".local/bin/update-composer".source = ./laravel-scripts/update-composer;
    ".local/bin/update-composer-inertia".source = ./laravel-scripts/update-composer-inertia;
    ".local/bin/update-package-json".source = ./laravel-scripts/update-package-json;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
  #  /etc/profiles/per-user/mau/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Create the .npm-global directory first
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.npm-global/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
