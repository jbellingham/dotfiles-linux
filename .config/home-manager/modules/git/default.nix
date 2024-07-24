{
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
}