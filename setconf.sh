#!/bin/sh
dir=$(cd $(dirname $0);pwd)
cd $dir
ln -sf $dir/tmux/tmux.conf ~/.tmux.conf
