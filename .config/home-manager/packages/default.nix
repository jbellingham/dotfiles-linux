{ pkgs, nixgl, ... }:
let nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
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
in with pkgs; [
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
    
    glibc
    adwaita-icon-theme
    # glibc_multi
    # libGl
    gnome-tweaks
    # toybox
    wine
    # winetricks
    
    # cli tools
    bat
    btop
    caffeine-ng
    fzf
    gnumake
    neofetch
    p7zip
    tldr
    jq
    xsel
    speechd

    python3

    gtk-engine-murrine
    gruvbox-gtk-theme


    # dev-related
    distrobox
    docker-compose
    lazydocker
    git-extras
    inxi
    nixd
    
    # gnome-extensions
    gnome-extension-manager

    # apps
    discord
    firefox
    meld
    obsidian
    slack

    nixgl.nixGLIntel
    # For some reason on a fresh install these need un-nixGLWrapped stuffs
    # wezterm
    _1password-gui
    lutris
    spotify
    (nixGLWrap wezterm)

    # System backups
    # https://github.com/linuxmint/timeshift
    timeshift

    # fonts
    fira-code
    hack-font
    meslo-lgs-nf
    monaspace
]
