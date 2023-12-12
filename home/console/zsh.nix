{ config, pkgs, ... }:

{
    programs = {
        zsh = {
            enable = true;
            oh-my-zsh = {
                enable = true;
                plugins = [
                    "git"
                ];
            };

            enableAutosuggestions = true;
            enableCompletion = true;
            enableSyntaxHighlighting = true;
        };
    };

}
