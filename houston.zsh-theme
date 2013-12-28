houston::initialize() {
  # Returns the dirty status and branch name of the working repository.
  houston::git_custom_status() {
    local cb=$(current_branch)
    if [ -n "$cb" ]; then
      echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
  }

  # Returns the number of unstaged changes in the working repository.
  houston::unstaged_change_count() {
    local cb=$(current_branch)
    if [ -n "$cb" ]; then
      git status --short | wc -l | sed -e 's/ //g' -e 's/ *$//g'
    fi
  }

  # Styles the appearence of the git prompt. Used by `git_custom_status`.
  houston::style_git_prompt() {
    ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[red]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
  }

  # Styles the appearence of clean/dirty status. Used by `parse_git_dirty`.
  houston::style_clean_and_dirty_status() {
    ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}*%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
  }

  # Configure the Right Prompt to display Git status.
  houston::initialize_right_prompt() {
    RPS1='$(houston::git_custom_status):%{$fg[magenta]%}$(houston::unstaged_change_count)%{$reset_color%} $EPS1'
  }

  # Configure the Prompt to display Git status.
  houston::initialize_prompt() {
    PROMPT='🚀  %{$fg[white]%}%~% %(?.%{$fg[magenta]%}.%{$fg[magenta]%})%B%b '
  }

  houston::style_git_prompt
  houston::style_clean_and_dirty_status
  houston::initialize_right_prompt
  houston::initialize_prompt
}

houston::initialize
