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

  file { "${home}/.gitignore":
    ensure => "link",
    target => "${dotfiles}/gitignore",
    require => Repository[$dotfiles]
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
