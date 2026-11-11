# OpenCode plugins

Plugins that let [OpenCode](https://opencode.ai) agents work with the systems you
already use: your machines, GitHub, Hugging Face, Jira and Confluence, Rhythms, RunPod, Azure
and Microsoft 365. Each one adds tools, a view in OpenCode (**Settings** and the
Review pane) and built-in know-how for agents, without changing how OpenCode
itself works.

| Plugin | What agents can do |
|---|---|
| [oc-machine](https://github.com/p-w-rs/oc-machine) | Use your SSH machines (keys, jump hosts, passwords, sudo) and env vars from their own shell |
| [oc-github](https://github.com/p-w-rs/oc-github) | Use `git` and `gh` with several GitHub accounts; the right login per command |
| [oc-huggingface](https://github.com/p-w-rs/oc-huggingface) | Find, download and upload models and datasets with `hf`, git and Python using your Hugging Face login; Hub search, papers and docs |
| [oc-atlassian](https://github.com/p-w-rs/oc-atlassian) | Search, read and update Jira issues and Confluence pages |
| [oc-rhythms](https://github.com/p-w-rs/oc-rhythms) | Read and update OKRs, check-ins and documents in Rhythms |
| [oc-runpod](https://github.com/p-w-rs/oc-runpod) | Manage RunPod pods, serverless and storage; SSH and rsync into pods |
| [oc-azure](https://github.com/p-w-rs/oc-azure) | Use the Azure CLI with your sign-in; SSH into VMs; Entra ID, DevOps, AI |
| [oc-m365](https://github.com/p-w-rs/oc-m365) | Outlook mail and calendar, Teams, OneDrive and SharePoint (your IT may need to approve access) |
| [oc-claude](https://github.com/p-w-rs/oc-claude) | Use Claude models in OpenCode with your own Claude sign-in (`/connect` → OpenClaude). Unofficial; check your account's terms |
| [oc-enhance](https://github.com/p-w-rs/oc-enhance) | Task notes with a Pause/Resume button (stops background commands, saves a notes checkpoint) and handoffs to colleagues; reminders agents set for themselves; top-of-mind cues so agents don't forget their tools in long chats; read Word, Excel, PowerPoint and PDF; search a project by meaning; shared terminals |
| [oc-pixi](https://github.com/p-w-rs/oc-pixi) | Agents use Pixi instead of pip/uv/conda: scripts with their dependencies inside (Python, R, C++ …), workspaces for projects in any language, a hint whenever they bypass Pixi, and the full Pixi docs bundled. Skip it if your team doesn't use Pixi |
| [oc-knowhow](https://github.com/p-w-rs/oc-knowhow) | Expert know-how agents load when needed: statistics, experiment design and ablations, datasets, field-specific methods, gnuplot figures (2D/3D, interactive, animated), diagrams (D2, Graphviz, Mermaid, TikZ), ML training/deployment (TensorRT 11, Jetson) and GPU kernels; plus a private reference library they search and cite (free references download to your computer; add your own folders) |

## Install

You need OpenCode 2.2.6 or newer (CLI or Desktop), [Pixi](https://pixi.sh)
(`curl -fsSL https://pixi.sh/install.sh | sh`) and git, on macOS or Linux.

```sh
git clone https://github.com/p-w-rs/oc-plugins.git
oc-plugins/install.sh            # pick plugins from a list
oc-plugins/install.sh all        # or name them: oc-plugins/install.sh github azure
```

Each plugin is cloned next to `oc-plugins/`, tested, and installed as a
verified snapshot into your OpenCode config (`~/.config/opencode`). Then restart
OpenCode (or `/reload`) and add your accounts under **Settings**, or simply ask
your agent, e.g. "connect my GitHub account" or "set up Jira for acme.atlassian.net".

For oc-claude, run `/connect` → **OpenClaude** in OpenCode to sign in, then pick an
`open-claude/...` model in `/models`. oc-enhance's features are all on; turn them off,
or download its meaning-based search (about 290 MB), under **Settings → Enhance**. For oc-knowhow, click **Download free references** under **Settings → Know-how** and add your own folders of books and papers there.

Run `install.sh` again to update. To remove a plugin: `cd oc-<name> && pixi run uninstall`.

## How they behave

The account plugins (machine through m365, and huggingface) share these rules; oc-claude and
oc-enhance follow the same "don't change vanilla OpenCode" rule.

- **Agents never see your secrets.** Tokens, keys and passwords are stored
  encrypted in `~/.local/share/oc-<name>` and supplied only to the command or
  call that needs them; output is masked.
- **You decide what agents may do.** Each plugin has a permission table
  (allow / ask / deny, per agent and per account) in its view. Reading and
  everyday changes run; things that cost money, delete, change access or are
  seen by other people (sending mail, posting, sharing) ask first by default.
  **Allow always** on a prompt updates the table.
- **Vanilla OpenCode keeps working.** The plugins never block or slow down
  OpenCode's own tools; if a plugin fails, it disables itself.
- **Portable.** Export and Import (in each view) move accounts, permissions and
  sign-ins to another computer in one passphrase-encrypted file.

See each plugin's README for details, setup tips and limitations.
