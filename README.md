# myOwnArchInstall
My own archinstall script, because I've been installing it 5 time this week and I'm tired of installing it manually.

-- WORK IN PROGRESS --<br>
After putting everything in place, execute this :
```sh
sudo pacman -S eza zoxide $(pacman -Sgq nerd-fonts) ruby npm
sudo gem install solargraph --user
sudo npm install -g pyright
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```
