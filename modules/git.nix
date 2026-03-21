# Git settings and aliases

{ ... }:

{
  home.shellAliases = {
    gs = "git switch";
    gr = "git restore";
    gst = "git status";
    gcm = "git commit -m";
    gca = "git commit --amend";
    gp = "git push";
    gpf = "git push --force-with-lease";
    grh = "git reset --hard head";
    gri = "git rebase -i";
    grc = "git rebase --continue";
    gaa = "git add --all";
    gc = "git commit";
    gco = "git checkout";
    gcp = "git add --all && git commit && git push";
    gcapf = "git add --all && git commit --amend && git push --force-with-lease";
    gpr = "gh pr view --web || gh pr create -f -w -B main -H $(git rev-parse --abbrev-ref HEAD)";
  };

  programs.git = {
    enable = true;

    # Replaces ~/.gitignore
    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "built-in-stubs.jar"
      "dumb.rdb"
      ".elixir_ls/"
      ".vscode/"
      "npm-debug.log"
    ];

    settings = {
      user = {
        name = "Guillaume Breton";
        email = "breton.gy@gmail.com";
      };

      alias = {
        lg = "log --graph -20 --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(bold blue)%an %Creset: %s %Cgreen(%cr)' --abbrev-commit --date=relative";
        l = "log --pretty=format:'%C(yellow)%h%Cred%d%Creset - %C(bold blue)%an %Creset: %s %Cgreen(%cr)'";
        ll = "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]' --decorate --numstat";
        st = "status --short";
      };

      core = {
        editor = "vi";
        pager = "delta --dark";
        whitespace = "trailing-space,space-before-tab";
      };

      push = {
        default = "current";
        followTags = true;
      };

      branch = {
        autosetuprebase = "always";
      };

      rebase = {
        autosquash = true;
      };
    };
  };
}
