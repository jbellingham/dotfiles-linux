{ pkgs, ... }: {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        eamodio.gitlens
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
    };
}