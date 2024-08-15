{ ... } : {
  imports = [
    ./direnv.nix
    ./zsh.nix
  ];

  programs = {
    autojump = {
      enable = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    mcfly = {
      enable = true;
      fzf.enable = true;
    };

    oh-my-posh = {
      enable = true;
      useTheme = "1_shell";
    };

    vim.enable = true;
  };
}