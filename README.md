# dotfiles

NOTE: This repository include my ([vec2pt](https://github.com/vec2pt)) persanal dotfiles. Not all configurations were written by myself, some of the settings were based on dotfiles available on GitHub.

## Installation

In this repo used GNU Stow to manage dotfiles. Link to Bastian Venthur's tutorial: [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html).


Command to install `zsh`, `git`, `starship` and `pylint` dotfiles:

```bash
stow -t $HOME zsh git starship pylint
```

## TODO

- Check unused dotfiles: bash, nano, conda, pylint.
- Add vimrc
- Test [micro](https://github.com/zyedidia/micro) dotfiles.
- Add colors aliases:
  - https://nick3499.medium.com/bash-echo-text-color-background-color-e8d8c41d5a91
  - https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
- Add `.termux/termux.properties` file. (?)

### Maybe someday there
- Check the bash framework [oh-my-bash](https://github.com/ohmybash/oh-my-bash).
- Check the zsh configuration frameworks (e.g.: [zimfw](https://github.com/zimfw/zimfw), [prezto](https://github.com/sorin-ionescu/prezto) etc).
- Check the zsh frameworks/prompts (e.g.: [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh), [pure](https://github.com/sindresorhus/pure), [powerlevel10k](https://github.com/romkatv/powerlevel10k)).
