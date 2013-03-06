class dotfiles {
  $home = "/Users/${::luser}"
  $my = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure => "directory",
    owner => $::luser,
    group => "staff"
  }

  repository { $dotfiles:
    source => "${::github_login}/dotfiles",
    require => File[$my]
  }

  exec { "cp -r ${dotfiles}/fonts/SourceCodePro ${home}/Library/Fonts/SourceCodePro":
    creates => "${home}/Library/Fonts/SourceCodePro",
    require => Repository[$dotfiles]
  }

  file { "${home}/.zsh":
    ensure => "link",
    target => "${dotfiles}/zsh",
    require => Repository[$dotfiles]
  }

  file { "${home}/.zshrc":
    ensure => "link",
    target => "${dotfiles}/zshrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/.tmux.conf":
    ensure => "link",
    target => "${dotfiles}/tmux.conf",
    require => Repository[$dotfiles]
  }

  git::config::global { 
    "color.ui": value  => "auto";
    "alias.ci": value  => "commit";
    "alias.co": value  => "checkout";
    "alias.st": value  => "status";
    "alias.br": value  => "branch";
    "alias.staged": value  => "diff --staged";
    "user.name": value => "cory";
    "user.email": value => "cory.monty@gmail.com";
    "credential.helper": value => "/opt/boxen/bin/boxen-git-credential";
    "core.excludesfile": value => "/opt/boxen/config/git/gitignore";
  }

  file { "${home}/.vimrc":
    ensure => "link",
    target => "${dotfiles}/vimrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/.vim":
    ensure => "directory"
  }

  file { "${home}/.vim/colors":
    ensure => "link",
    target => "${dotfiles}/vim/colors",
    require => [
      File["${home}/.vim"],
      Repository[$dotfiles]
    ]
  }
}
