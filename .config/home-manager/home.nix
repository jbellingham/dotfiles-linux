# Some nix config inspiration...
# https://github.com/gilescope/nix-all

# Home manager options
# https://nix-community.github.io/home-manager/options.xhtml

# https://github.com/mikeroyal/Pop_OS-Guide?tab=readme-ov-file

# Gaming on Linux
# https://usebottles.com/

# Pop on Wayland
# /etc/gdm3/custom.conf
# Set WaylandEnable=true
# Log out, and on login screen, cog -> Pop on Wayland

{ config, pkgs, lib, nixgl, ... }: {
  xdg = {
    enable = true;
    configFile."wezterm/wezterm.lua".source = ./modules/wezterm/wezterm.lua;
  };
  fonts.fontconfig.enable = true;
  home = {
    packages = import ./packages { inherit pkgs nixgl; };
  
    # home.file.".config/wezterm/wezterm.lua".text = builtins.readFile ./wezterm.lua;
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "jesse";
    homeDirectory = "/home/jesse";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.05"; # Please read the comment before changing.


    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
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

    sessionVariables = {
      VISUAL = "code --wait";
      EDITOR = "$VISUAL";
      SHELL = "zsh";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    autojump = {
      enable = true;
      enableZshIntegration = true;
    };

    direnv = import ./modules/direnv;

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = import ./modules/git;

    mcfly = {
      enable = true;
      fzf.enable = true;
    };

    oh-my-posh = {
      enable = true;
      useTheme = "1_shell";
    };

    vim.enable = true;

    vscode = import ./modules/vscode { inherit pkgs; };
    zsh = import ./modules/zsh { inherit pkgs; };
  };
}