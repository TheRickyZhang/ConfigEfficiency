# Git Configuration

## Global Git Configuration
Run these commands:

git config --global push.default current
git config --global pull.rebase true
git config --global fetch.prune true
git config --global diff.colorMoved zebra

git config --global alias.pushf 'push --force-with-lease'
git config --global alias.ch 'checkout'
git config --global alias.rb 'rebase'
git config --global alias.ck 'checkout'
git config --global alias.chp 'cherry-pick'
git config --global alias.pom 'pull origin main'
git config --global alias.ss 'status'

git config --global alias.staash 'stash --all'
git config --global alias.blaame 'blame -w -C -C -C -L'
git config --global rerere.enabled true

## Project-Specific Git Maintenance
Run the following command in each project:
git maintenance start
