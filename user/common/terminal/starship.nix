{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      right_format = "$cmd_duration";

      directory = {
        format = "[ ](bold #89b4fa)[ $path ]($style)";
        style = "bold #b4befe";
      };

      character = {
        success_symbol = "[ ](bold #89b4fa)[ ➜](bold green)";
        error_symbol = "[ ](bold #89b4fa)[ ➜](bold red)";
      };

      cmd_duration = {
        format = "[]($style)[[󰔚 ](bg:#161821 fg:#d4c097 bold)$duration](bg:#161821 fg:#BBC3DF)[ ]($style)";
        disabled = false;
        style = "bg:none fg:#161821";
      };

      palette = "catppuccin_mocha";
    };
  };
}
