{ lib, ... }:
{
  users.users = {
    kanade = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "$y$j9T$C0UuVeSpwcZT/Ig7k/IIK0$W0jxMqKUPiExoWaQ0TWiO8ZL9I5eg2t5MH8N/EBz2B0";
      extraGroups = lib.mkAfter [ "wheel" "networkmanager" "tss" ];
    };
  };

  nix.settings.trusted-users = [ "kanade" ];
  services.greetd.settings.initial_session.user = "kanade";
}
