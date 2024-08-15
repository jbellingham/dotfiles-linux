{ pkgs, ... }: {
    programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        extensions = with pkgs.vscode-extensions; [
            eamodio.gitlens
            jnoortheen.nix-ide
            ms-vscode.makefile-tools
            shopify.ruby-lsp
            wakatime.vscode-wakatime
        ];
        userSettings = {
            "editor.fontSize" = 16;
            "editor.cursorStyle" = "line";
            "terminal.integrated.fontSize" = 16;
            "editor.renderWhitespace" = "all";
            "debug.console.fontFamily" = "'Monaspace Argon', monospace";
            "terminal.integrated.fontFamily" = "MesloLGS NF";
            "editor.fontFamily" = "'Monaspace Argon', monospace";
            "git.autofetch" = true;
            "nix.enableLanguageServer" = true;
            "nix.serverPath" = "nixd";
            "nixd.options.enable" = true;
        };
    };
}