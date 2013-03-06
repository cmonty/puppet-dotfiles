class dotfiles {
  require vim

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

  file { "${home}/.gitconfig":
    ensure => "link",
    target => "${dotfiles}/gitconfig",
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

  file { "${home}/.vimrc":
    ensure => "link",
    target => "${dotfiles}/vimrc",
    require => Repository[$dotfiles]
  }

  file { "${home}/.vim/colors":
    ensure => "link",
    target => "${dotfiles}/vim/colors",
    require => Repository[$dotfiles]
  }

  vim::bundle { "https://github.com/benmills/vimux": }
  vim::bundle { "https://github.com/c9s/bufexplorer": }
  vim::bundle { "https://github.com/kien/ctrlp.vim": }
  vim::bundle { "https://github.com/rodjek/vim-puppet": }
  vim::bundle { "https://github.com/scrooloose/nerdtree": }
  vim::bundle { "https://github.com/tomtom/tcomment_vim": }
  vim::bundle { "https://github.com/tpope/vim-rails": }
  vim::bundle { "https://github.com/vim-ruby/vim-ruby": }
  vim::bundle { "https://github.com/vim-scripts/Align": }
}
