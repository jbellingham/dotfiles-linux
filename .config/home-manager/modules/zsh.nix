{ pkgs, ... }: {
    programs.zsh = {
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
            say = "spd-say";
            pbcopy = "xsel --clipboard --input";
            pbpaste = "xsel --clipboard --output";
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
}