{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # Sets alias vim=nvim
    vimAlias = true;

    extraConfig = ''
      :imap jk <Esc>
      :set number
    '';

    # Neovim plugins
    plugins = with pkgs.vimPlugins; [
      ctrlp
      editorconfig-vim
      tabular
    ];
  };
}
