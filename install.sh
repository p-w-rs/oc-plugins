#!/bin/sh
# Installs oc-* OpenCode plugins: clones (or updates) each repo next to this script and runs its installer.
#   ./install.sh                       # asks which plugins to install
#   ./install.sh machine github azure  # installs these (names with or without the oc- prefix)
#   ./install.sh all
# Needs git and pixi (https://pixi.sh). Re-run any time to update.
set -eu

ALL="machine github atlassian rhythms runpod azure m365"
BASE="${OC_PLUGINS_BASE:-https://github.com/p-w-rs}"
DIR="$(cd "$(dirname "$0")" && pwd)"
WHERE="${OC_PLUGINS_DIR:-$(dirname "$DIR")}"

describe() {
  case "$1" in
    machine) echo "SSH machines, sudo and env vars for agents" ;;
    github) echo "GitHub accounts for git and gh, per-account permissions" ;;
    atlassian) echo "Jira and Confluence" ;;
    rhythms) echo "Rhythms OKRs, check-ins and documents" ;;
    runpod) echo "RunPod pods, serverless, storage, SSH into pods" ;;
    azure) echo "Azure via the Azure CLI, SSH into VMs" ;;
    m365) echo "Outlook mail and calendar, Teams, OneDrive, SharePoint" ;;
  esac
}

for tool in git pixi; do
  command -v "$tool" >/dev/null 2>&1 || { echo "Missing $tool. Install it first${tool = pixi && echo ': curl -fsSL https://pixi.sh/install.sh | sh' || echo ''}." >&2; exit 1; }
done

if [ "$#" -eq 0 ]; then
  echo "Which plugins? (space-separated names, or 'all')"
  for name in $ALL; do printf '  %-10s %s\n' "$name" "$(describe "$name")"; done
  printf '> '
  read -r answer
  set -- $answer
fi
[ "${1:-}" = all ] && set -- $ALL
[ "$#" -gt 0 ] || { echo "Nothing selected." >&2; exit 1; }

failed=""
for item in "$@"; do
  name="${item#oc-}"
  case " $ALL " in *" $name "*) ;; *) echo "Unknown plugin: $item (choose from: $ALL)" >&2; failed="$failed $name"; continue ;; esac
  repo="$WHERE/oc-$name"
  echo
  echo "== oc-$name: $(describe "$name")"
  if [ -d "$repo/.git" ]; then git -C "$repo" pull --ff-only -q
  else git clone -q "$BASE/oc-$name.git" "$repo"
  fi
  if (cd "$repo" && pixi run --locked install); then :; else failed="$failed $name"; fi
done

echo
if [ -n "$failed" ]; then echo "Failed:$failed (see the output above)"; exit 1; fi
echo "Done. Restart OpenCode (or /reload), then open Settings to add accounts, or ask your agent to set them up."
