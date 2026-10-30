<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="assets/logo-dark.svg" />
    <img src="assets/logo-light.svg" alt="Lab Rat logo" width="80" height="80" />
  </picture>
</p>
<h1 align="center">Lab Rat</h1>

Lab Rat teaches your AI coding agent to work like a careful ML researcher: reproduce papers, launch and compare runs at the same epoch, and check every claim before it costs you weeks of compute.

<p align="center">
  <a href="#install">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="assets/tools-dark.svg" />
      <img src="assets/tools-light.svg" alt="Works in Claude Code, Codex, Cursor and Gemini CLI" width="454" height="24" />
    </picture>
  </a>
</p>

Built by [Fatih Cagatay Akyon](https://scholar.google.com/citations?user=RHGyDE0AAAAJ) (2000+ citations, 5 patents) from 2200+ Claude Code and Codex sessions. Every guardrail traces to a real mistake.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/flow-dark.svg" />
  <img src="assets/flow-light.svg" alt="Find papers, reproduce, design, launch, compare and publish, with compare looping back to design for the next experiment" width="980" />
</picture>

## Install

<details open>
<summary><b>Claude Code</b></summary>

```sh
claude plugin marketplace add fcakyon/labrat
claude plugin install labrat@labrat
```

Update with `claude plugin update labrat@labrat`.

Coming from phd-skills? Remove it first with `claude plugin uninstall phd-skills@phd-skills` and `claude plugin marketplace remove phd-skills`.

</details>

<details>
<summary><b>Claude.ai and Claude Desktop</b></summary>

Open **Customize**, then **Plugins**. Select **Add**, then **Add marketplace**, choose **Add from a repository** and enter `fcakyon/labrat`. Install Lab Rat from the **Discover** tab.

Needs a paid plan. Chat runs the skills. The plugin also syncs to Claude Code when you sign in there with the same account.

</details>

<details>
<summary><b>Codex</b></summary>

```sh
codex plugin marketplace add fcakyon/labrat
codex plugin add labrat@labrat
```

Update with `codex plugin marketplace upgrade labrat`.

</details>

<details>
<summary><b>Cursor</b></summary>

```sh
cursor-agent plugin marketplace add https://github.com/fcakyon/labrat
```

Then start `cursor-agent`, enter `/plugin` and install Lab Rat. To update, run `cursor-agent plugin marketplace remove labrat`, add it again and reinstall.

</details>

<details>
<summary><b>Gemini CLI</b></summary>

```sh
git clone https://github.com/fcakyon/labrat ~/.labrat
gemini extensions link ~/.labrat/plugin
```

Update with `git -C ~/.labrat pull`.

</details>

Every option gets the same 11 skills. The guardrail hooks run in Claude Code only.

Paper search and acquisition use [Paper Search CLI](https://github.com/fcakyon/paper-search-cli), installed with uv and Python 3.10+. See [paper search setup](plugin/skills/literature-research/references/paper-search.md). Other skills do not require it.

The plugin works correctly the moment it is installed. Optional: run `/labrat:setup` for a 30-second tour of what was auto-detected and to opt into extras (notifications, allowlist, LaTeX).

## Usage

Open Claude Code in your project directory, then:

- `/labrat:reproduce arxiv 2508.12345` reproduce a paper from arxiv URL through replication runs
- `"why is my loss diverging?"` the `debug` skill auto-triggers, runs evidence-first probes
- `"compare run alpha to baseline"` the `compare` skill auto-triggers, aligns at the same epoch
- `"launch the new training run"` the `launch` skill auto-triggers, runs the pre-flight checklist
- `/loop 30m check experiment logs, notify me if metrics beat the baseline or if loss starts to diverge`

Notifications (task completion, background agents) forward to ntfy / Slack / email after `/labrat:setup`.

## Why This Plugin Exists

AI agents make research mistakes that cost weeks of compute. Real ones from my sessions:

- It typed "done?" as "dont?" and launched an unwanted upload of thousands of files
- It restarted a 50-hour training job without diffing the config against the reference run, lost three days
- It killed an experiment over a non-converged proxy metric, before downstream eval would have shown the truth
- It ran `rm -rf` on a path it had hallucinated from memory, lost local checkpoints

Other plugins give you more commands. **This plugin gives you guardrails.**

## What You Get

### Skills (auto-trigger, or run as `/labrat:<skill>`)

| When you say...                                                       | Skill activates                                                   |
| --------------------------------------------------------------------- | ----------------------------------------------------------------- |
| "find related papers on X" / "find gaps in the literature on X"       | [Literature Research](plugin/skills/literature-research/SKILL.md) |
| "reproduce this arxiv paper"                                          | [Reproduce](plugin/skills/reproduce/SKILL.md)                     |
| "design an ablation study"                                            | [Experiment Design](plugin/skills/experiment-design/SKILL.md)     |
| "launch a new training run" / "kick off training"                     | [Launch](plugin/skills/launch/SKILL.md)                           |
| "why is X failing / diverging / OOMing"                               | [Debug](plugin/skills/debug/SKILL.md)                             |
| "compare run A to baseline"                                           | [Compare](plugin/skills/compare/SKILL.md)                         |
| "analyze dataset bias"                                                | [Dataset Curation](plugin/skills/dataset-curation/SKILL.md)       |
| "check if my numbers match the code" / "verify my BibTeX" / "prepare code for release" | [Paper Check](plugin/skills/paper-check/SKILL.md) |
| "review my methods section for consistency" / "setup latex for CVPR"  | [Paper Write](plugin/skills/paper-write/SKILL.md)                 |
| "what will reviewers ask about this?" / "pick my strongest ablations" | [Rebuttal](plugin/skills/rebuttal/SKILL.md)                       |
| `/labrat:setup`                                                   | [Setup](plugin/skills/setup/SKILL.md)                             |

### Research Guardrails (run silently, you never invoke these)

| What it catches                                                                                           |
| --------------------------------------------------------------------------------------------------------- |
| [Conclusions reviewed against actual artifacts by a fresh-context research peer](plugin/hooks/claude-hooks.json) |
| [Pointer to the launch skill when an ML training job starts](plugin/scripts/launch_context.sh)            |

## How It Compares

|                                           | Lab Rat                     | flonat/claude-research       | Others       |
| ----------------------------------------- | --------------------------- | ---------------------------- | ------------ |
| Commands to learn                         | 1 (skills auto-trigger)     | 39                           | 13-20        |
| Research integrity hooks                  | 2 (agent + 1 command hook)  | 1                            | 0            |
| Paper reproduction (arxiv to runs)        | **Yes** (7-stage skill)     | No                           | No           |
| Paper-code consistency audit              | 6 checks                    | Read-only, no code cross-ref | None         |
| Experiment monitoring + SSH notifications | Yes (ntfy / slack / email)  | No                           | No           |
| External dependencies                     | **Paper Search CLI for paper workflows**                    | npm + pip + MCP servers      | MCP required |
| Install time                              | 30 seconds                  | 10+ minutes                  | Varies       |

## Design Principles

1. **Methodology over scripts**. Skills teach the approach, Claude generates code for your specific setup (wandb, neptune, local files, whatever)
2. **Human oversight first**. Claude makes premature claims and jumps to conclusions. Every skill builds in verification checkpoints
3. **Actionable output**. Ranked suggestions with specific fixes, never just a list of findings

## License

MIT. Use it, fork it, adapt it to your research.

## Thank you for the support!

[![Star History Chart](https://api.star-history.com/svg?repos=fcakyon/labrat&type=Date)](https://www.star-history.com/#fcakyon/labrat&Date)

## Contributors

<p align="center">
    <a href="https://github.com/fcakyon/labrat/graphs/contributors">
      <img src="https://contrib.rocks/image?repo=fcakyon/labrat" />
    </a>
</p>
