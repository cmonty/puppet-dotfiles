# Dotfiles

Puppet module to include my dotfiles when using boxen.

## Usage

```puppet
boxen::example { 'best example ever':
  include dotfiles
}
```

## Required Puppet Modules

* `boxen`

## Development

Write code. Run `script/cibuild` to test it. Check the `script`
directory for other useful tools.
