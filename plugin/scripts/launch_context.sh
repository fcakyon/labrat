#!/usr/bin/env bash
# PreToolUse hook: point at the launch skill when an ML training job is
# about to start. Adds context only, never a permission decision. Covers
# PyTorch, JAX, TF, HF Trainer, accelerate, DeepSpeed and SLURM launchers.

set -uo pipefail

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty' 2> /dev/null)

if [ -z "$command" ]; then
  exit 0
fi

launcher_pattern='python\s+[^|&;]*\b(train|run|main|fit)\b[^|&;]*\.py|accelerate\s+launch|torchrun\b|deepspeed\b|sbatch\b|tmux\s+new-session\s+[^|&;]*python\s+[^|&;]*\b(train|run|main|fit)\b|wandb\s+sweep|nohup\s+python\b[^|&;]*\b(train|run|main|fit)\b'

if ! echo "$command" | grep -qiE "$launcher_pattern"; then
  exit 0
fi

cat << 'EOF'
{"hookSpecificOutput":{"hookEventName":"PreToolUse","additionalContext":"A training job is about to start. The /phd-skills:launch skill checks the config, run name, paths and monitoring first."}}
EOF
exit 0
