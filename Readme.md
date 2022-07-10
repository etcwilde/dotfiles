# My Configurations
*Author:* etc 2022 <etceterawilde@gmail.com>

These are my configuration files. Some changes are more extensive than others.

Installation is powered by a makefile, which creates the appropriate symlinks
for the various tools that can be configured. The script currently supports
installing on Linux and Darwin platforms.

The full list of tools includes for which configurations are installed are as
follows:
 - git
 - i3
 - lldb
 - neovim
 - rofi
 - tmux
 - zsh

I also have profiles for `alacritty`, the default macOS terminal, and `termite`
terminal emulators. Those are not installed by the script though and will need
to be installed manually.

## Installation:

To install the appropriate configurations for your platform, run:

```sh
$ make install
```

To install an individual component, you can run

```sh
$ make <component>
```

Installing per component will install the configuration for that tool,
regardless of whether it applies to your platform or not.

If a configuration file for the tool already exists, the installer will not
write over the top of the existing file.

Finally, if you want to install the components for a different system, you can
run the following, replacing `<system>` with the output from `uname -s`.
```sh
$ make install_<system>
```
