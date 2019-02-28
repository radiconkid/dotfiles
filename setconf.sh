#!/bin/sh
dir=$(cd $(dirname $0);pwd)
cd $dir
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac

# tmux.conf
MAC_COPY="pbcopy"
MAC_PASTE="pbpaste | tmux load-buffer - ; tmux paste-buffer"
LINUX_COPY="xclip -i -sel clip \> \/dev\/null"
LINUX_PASTE="xclip -o -sel clip | tmux load-buffer - ; tmux paste-buffer"

cp -f $dir/tmux/tmux.conf /tmp/.tmux.conf
if [ $machine = Linux ]; then
    sed -ie "s/\%COPY\%/\"$LINUX_COPY\"/g" /tmp/.tmux.conf
    sed -ie "s/\%PASTE\%/\"$LINUX_PASTE\"/g" /tmp/.tmux.conf
elif [ $machine = "Mac" ]; then
    sed -ie "s/\%COPY\%/\"$MAC_COPY\"/g" /tmp/.tmux.conf
    sed -ie "s/\%PASTE\%/\"$MAC_PASTE\"/g" /tmp/.tmux.conf
fi
cp -f /tmp/.tmux.conf ~/

# vimrc
rm ~/.vimrc
cp $dir/vim/vimrc ~/.vimrc
