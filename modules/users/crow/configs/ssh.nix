{
  programs.ssh = {
    enable = true;
    extraConfig = ''
        Host github.com
        User git
        PreferredAuthentications publickey
        IdentityFile /home/crow/.ssh.id_ed25519
      Host Overseer
        User overseer
        HostName 192.168.0.30
        IdentityFile /home/crow/.ssh/wanderingcrow
    '';
  };
}
