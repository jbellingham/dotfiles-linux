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
    
    # cli tools
    bat
    btop
    caffeine-ng
    fzf
    neofetch
    tldr
    jq

    # dev-related
    distrobox
    lazydocker
    git-extras
    inxi
    
    # gnome-extensions
    gnomeExtensions.vitals

    discord
    firefox
    meld
    obsidian
    slack

    nixgl.nixGLIntel
    (nixGLWrap _1password-gui)
    (nixGLWrap spotify)
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