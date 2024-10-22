#!/bin/bash

echo "check what is my home: $HOME" > /home/user/entrypoint.log
# Check if Oh My Bash is installed
if [ ! -d "$HOME/.oh-my-bash" ]; then
  echo "Oh My Bash not found. Installing..."
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
fi

SNUM=$(echo $DISPLAY | sed 's/:\([0-9][0-9]*\)/\1/')
xvfb-run -n $SNUM -s "-screen 0 1024x768x24" -f ~/.Xauthority openbox-session &
sleep 1
x11vnc -display $DISPLAY -usepw -forever -quiet &

exec "$@"

tail -f /dev/null
