{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ponzi";
  home.homeDirectory = "/home/ponzi";

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    shellAliases = {
      ll = "ls -l";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
 
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git"
      ];
      theme = "agnoster";
    };
  };
 
  programs.bat.enable = true;

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ 
      vim-airline 
    ];
    settings = { ignorecase = true; };
    extraConfig = ''
      syntax on
      set number
      set expandtab
      set bs=2
      set tabstop=2
      set shiftwidth=2
    '';
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
    ];
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    shortcut = "a";
  };
}
