# dotfiles

> [!NOTE]
> This repository include my ([vec2pt](https://github.com/vec2pt)) persanal dotfiles. Not all configurations were written by myself, some of the settings were based on dotfiles available on GitHub. Feel free to copy some code parts and/or fork the repository for your own needs.

## Installation

In this repo used [GNU Stow](https://www.gnu.org/software/stow/) to manage dotfiles. Useful link: [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html) from Bastian Venthur's Blog.

Example command to install `zsh`, `git`, `starship` and `fastfetch` dotfiles:

```bash
stow -t $HOME zsh git starship fastfetch
```

Command to install dotfiles for Swaywm:

```bash
stow -t $HOME sway swaylock waybar dunst rofi
```


## TODO

- Add vimrc
- Try [delta](https://github.com/dandavison/delta).
- Test [micro](https://github.com/zyedidia/micro) editor.

