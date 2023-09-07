# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin "janoamaral/tokyo-night-tmux"

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
setw -g mode-keys vi

bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection c"
