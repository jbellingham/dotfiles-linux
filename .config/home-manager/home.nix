{ config, pkgs, lib, nixgl,  ... }:

let
  nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
    mkdir $out
    for folder in $(cd ${pkg} && find -L -type d -links 2); do
      folder=$(echo $folder | cut -c 2-)
      mkdir -p "$out$folder"
    done;
    for file in $(cd ${pkg} && find -L); do
      file=$(echo $file | cut -c 2-)
      if [[ -f ${pkg}$file ]]; then
        if [[ $file == *.desktop ]]; then
          cp "${pkg}$file" "$out$file"
          sed -i 's|TryExec=.*||' "$out$file"
          sed -i 's|Exec=|Exec=nixGLIntel |' "$out$file"
        else
          ln -s "${pkg}$file" "$out$file"
        fi
      fi
    done;
  '';
in {
  # ...
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    # nixgl.auto.nixGLDefault
    bat
    btop
    fzf
    git-extras
    jq
    meld
    oh-my-posh
    tldr
    wakatime

    # fonts
    fira-code
    hack-font
    meslo-lgs-nf
    monaspace

    nixgl.nixGLIntel
    # (nixGLWrap spotify)
    (nixGLWrap wezterm)
  ];

  fonts.fontconfig.enable = true;
  
  # home.file.".config/wezterm/wezterm.lua".text = builtins.readFile ./wezterm.lua;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jesse";
  home.homeDirectory = "/home/jesse";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.


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
  #  /etc/profiles/per-user/jesse/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    NIXPKGS_ALLOW_UNFREE = 1;
    SHELL = "zsh";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      includes = [
        { path = "~/.config/home-manager/modules/git/.gitconfig"; }
      ];
      ignores = [
        "/*"
        "!.config"
        ".config/*"
        "!.config/home-manager"
      ];
    };

    autojump = {
      enable = true;
      enableZshIntegration = true;
    };

    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
            # bbenoist.Nix
            # justusadam.language-haskell
            wakatime.vscode-wakatime
        ];
      userSettings = {
        "editor.fontSize" = "16";
        "editor.cursorStyle" = "line";
        "terminal.integrated.fontSize" = "16";
        "editor.renderWhitespace" = "all";
        "debug.console.fontFamily" = "'Monaspace Argon', monospace";
        "terminal.integrated.fontFamily" = "MesloLGS NF";
        "editor.fontFamily" = "'Monaspace Argon', monospace";
        };
    };

    oh-my-posh = {
      enable = true;
      useTheme = "1_shell";
    };

    zsh = {
      # Ensure zsh is installed and enabled as the default shell
      # command -v zsh | sudo tee -a /etc/shells
      # chsh -s $(which zsh)
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;

      shellAliases = {
        update = "(cd ~/.config/home-manager && make)";
        ll = "ls -latr";

        cat = "bat";
        top = "btop";
        grep = "grep -iF --color=auto";
      };

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "v1.1.2";
            sha256 = "Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
          };
        }
      ];
    };
  };
}