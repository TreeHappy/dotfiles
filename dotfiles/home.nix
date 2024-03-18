{ config, pkgs, ... }:

{
  home.username = "halcyon";
  home.homeDirectory = "/home/halcyon";
  home.stateVersion = "23.11";
  home.packages = [
    pkgs.lazygit
    pkgs.nodejs_21
    pkgs.python3Minimal
    pkgs.gcc8
    pkgs.unzip
    pkgs.zoxide
    pkgs.bat
    pkgs.lsd
    pkgs.julia-bin
    pkgs.duckdb
    pkgs.dotnet-sdk_8
  ];

  home.file = {
    ".config/zellij/config.kdl".source = zellij/config.kdl;
    # ".config/nvim/lua/user/init.lua".source = nvim/init.lua;
    # ".config/nvim/lua/user/catui.lua".source = nvim/catui.lua;
  };

 home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    };
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    };
  programs.bash = {
    enable = true;
    profileExtra =
  	  ''exec zsh
  	  '';
    };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    shellAliases = {
      cat = "bat";
      ls = "lsd";
    };
  };
  programs.git = {
    enable = true;
  };
  programs.starship.enable = true;
  programs.lf.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
}
