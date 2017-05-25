# installer-tmux
Install tmux of specified version.

## Installation

### Install 2.4

```
$ bash setup.sh
```

### Install specified version

```
$ bash setup.sh {version}
```

## Usage

```
$ /usr/local/bin/tmux
```

## tmux.conf
set following on ~/.tmux.conf for scrolling .

```
set-option -g mouse on
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
```
