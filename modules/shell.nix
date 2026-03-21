{ pkgs, ... }:

{
  home.shellAliases = {
    # Better defaults
    grep = "rg";
    diff = "diff --color=auto";
    cat = "bat";
    find = "fd";
    ll = "ls -lh";
    tree = "ls -T";
    rm = "trash";

    # Nix
    switch = "nh home switch";
    garbage = "nix-collect-garbage -d && docker image prune --force";
    installed = "nix-env --query --installed";
    ns = "nix-shell shell.nix";

    # Task
    t = "task ls";
    tw = "task week";
    tom = "task tomorrow";
    tad = ''tad() {task add "$@" sched:today};tad'';
    tat = ''tat() {task add "$@" sched:tomorrow};tat'';
    tm = "tm() {task mod '$@' };tm";
    tsa = "tsa() {task $1 mod seg:A};tsa";
    tsm = "tsm() {task $1 mod seg:M};tsm";
    tse = "tse() {task $1 mod seg:E};tse";
    te = "te() {task $1 edit};te";
    td = "td() {task $1 mod sched:today};td";
    ts = "ts() {task $1 start};ts";
    tt = "tt() {task $1 mod sched:$2};tt";
    tp = "tp() {task $1 mod sched:tomorrow};tp";

    # Reload zsh
    reload = "source ~/.zshrc";
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "${pkgs.ripgrep}/bin/rg --no-messages --files --hidden --follow --glob '!.git/*'";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.extended = true;

    initContent = ''
      export TERM="xterm-256color"
      bindkey -e

      # Nix setup (environment variables, etc.)
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi

      # Load environment variables from a file
      if [ -e ~/.extras ]; then
        . ~/.extras
      fi

      # Start up Starship shell
      eval "$(starship init zsh)"

      # direnv setup
      eval "$(direnv hook zsh)"

      # Open a workspace in a tmux session
      ved(){
        selected=$1
        if [ -z $1 ]; then
          selected=`ls ~/Workspaces/ | fzf`
        fi
        if [ -z $selected ]; then
          return 0
        fi

        WORKING_DIRECTORY=$(cdpath=(. ~/Workspaces) cd $selected > /dev/null 2>&1 && pwd)
        echo "working directory: $WORKING_DIRECTORY"

        session_name=`echo $selected | sed 's/\./_/g'`
        if [ -z "$TMUX" ]; then
          tmux new-session -As $session_name -c $WORKING_DIRECTORY
        else
          if ! tmux has-session -t $session_name 2>/dev/null; then
            TMUX= tmux new-session -ds $session_name -c $WORKING_DIRECTORY
          fi
          echo "switching to $session_name session"
          tmux switch-client -t $session_name
        fi
      }
    '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
    ];
  };
}
