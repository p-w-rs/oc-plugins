# OpenCode plugins

Plugins that let [OpenCode](https://opencode.ai) agents work with the systems you
already use: your machines, GitHub, Jira and Confluence, Rhythms, RunPod, Azure
and Microsoft 365. Each one adds tools, a view in OpenCode (**Settings** and the
Review pane) and built-in know-how for agents, without changing how OpenCode
itself works.

| Plugin | What agents can do |
|---|---|
| [oc-machine](https://github.com/p-w-rs/oc-machine) | Use your SSH machines (keys, jump hosts, passwords, sudo) and env vars from their own shell |
| [oc-github](https://github.com/p-w-rs/oc-github) | Use `git` and `gh` with several GitHub accounts; the right login per command |
| [oc-atlassian](https://github.com/p-w-rs/oc-atlassian) | Search, read and update Jira issues and Confluence pages |
| [oc-rhythms](https://github.com/p-w-rs/oc-rhythms) | Read and update OKRs, check-ins and documents in Rhythms |
| [oc-runpod](https://github.com/p-w-rs/oc-runpod) | Manage RunPod pods, serverless and storage; SSH and rsync into pods |
| [oc-azure](https://github.com/p-w-rs/oc-azure) | Use the Azure CLI with your sign-in; SSH into VMs; Entra ID, DevOps, AI |
| [oc-m365](https://github.com/p-w-rs/oc-m365) | Outlook mail and calendar, Teams, OneDrive and SharePoint (your IT may need to approve access) |

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

Run `install.sh` again to update. To remove a plugin: `cd oc-<name> && pixi run uninstall`.

## How they behave

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
