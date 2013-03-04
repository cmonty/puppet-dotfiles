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

  file { "${home}/.gitconfig":
    ensure => "link",
    target => "${my}/dotfiles/gitconfig",
    require => Repository[$dotfiles]
  }


  file { "${home}/.zsh":
    ensure => "link",
    target => "${my}/dotfiles/zsh",
    require => Repository[$dotfiles]
  }

  file { "${home}/.zshrc":
    ensure => "link",
    target => "${my}/dotfiles/zshrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/.tmux.conf":
    ensure => "link",
    target => "${my}/dotfiles/tmux.conf",
    require => Repository[$dotfiles]
  }

  file { "${home}/.vimrc":
    ensure => "link",
    target => "${my}/dotfiles/vimrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/.vim":
    ensure => "link",
    target => "${my}/dotfiles/vim",
    require => Repository[$dotfiles]
  }
}
