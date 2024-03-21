# myOwnArchInstall
My own archinstall script, because I've been installing it 5 time this week and I'm tired of installing it manually.

### -- WORK IN PROGRESS --
After putting everything in place, execute this :
```sh
sudo pacman -S eza zsh zoxide $(pacman -Sgq nerd-fonts) ruby npm croc
sudo gem install solargraph --user
sudo npm install -g pyright
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
Then, relaunch your shell and configure p10k like this :
```txt
y y n y 1 y 3 1 2 3 1 1 2 1 1 2 2 1 y 1 y
```
