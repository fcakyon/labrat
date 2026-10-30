<p align="center"><img src="assets/labrat.svg" alt="Lab Rat logo" width="120"></p>

# Lab Rat

Catch AI mistakes before they cost weeks of compute. Reproduce papers from arxiv. Debug runs evidence-first. Compare experiments at the right epoch. Launch with discipline.

Built by [Fatih Cagatay Akyon](https://scholar.google.com/citations?user=RHGyDE0AAAAJ)
(2000+ citations, 5 patents) after 300+ Claude Code sessions, tens of
critical AI mistakes caught the hard way, and thousands of hours of
PhD research. Every guardrail in this plugin traces to a real mistake.

![Claude Code Plugin](https://img.shields.io/badge/Claude_Code-Plugin-blue)
![MIT License](https://img.shields.io/badge/License-MIT-green)
![Zero Dependencies](https://img.shields.io/badge/Dependencies-Zero-brightgreen)
![No MCP Required](https://img.shields.io/badge/MCP-Not_Required-lightgrey)

---

Paper search and acquisition use [Paper Search CLI](https://github.com/fcakyon/paper-search-cli), installed with uv and Python 3.10+. See [paper search setup](plugin/skills/literature-research/references/paper-search.md). Other skills do not require it.

## Why This Plugin Exists

Claude Code is powerful, but it makes research-specific mistakes that cost weeks of compute:

- It typed "done?" as "dont?" and launched an unwanted upload of thousands of files
- It analyzed my full dataset when I asked for a specific 4k/2k/2k split
- It claimed a test covered a bug it had never actually verified
- It never once looked at a figure it generated, just trusted the numbers
- It restarted a 50-hour training job without diffing the config against the reference run, lost three days
- It claimed an experiment was diverging based on a non-converged proxy metric, killed it before downstream eval would have shown the truth
- It ran `rm -rf` on a path it had hallucinated from memory, lost local checkpoints

Other plugins give you more commands. **This plugin gives you guardrails.**

---

## Install

```
claude plugin marketplace add fcakyon/labrat
claude plugin install labrat@labrat
```

Coming from phd-skills? Remove it first with `claude plugin uninstall phd-skills@phd-skills` and `claude plugin marketplace remove phd-skills`.

The plugin works correctly the moment it is installed. Optional: run `/labrat:setup` for a 30-second tour of what was auto-detected and to opt into extras (notifications, allowlist, LaTeX).

---

## Usage

Open Claude Code in your project directory, then:

- `/labrat:reproduce arxiv 2508.12345` reproduce a paper from arxiv URL through replication runs
- `"why is my loss diverging?"` the `debug` skill auto-triggers, runs evidence-first probes
- `"compare run alpha to baseline"` the `compare` skill auto-triggers, aligns at the same epoch
- `"launch the new training run"` the `launch` skill auto-triggers, runs the pre-flight checklist
- `/loop 30m check experiment logs, notify me if metrics beat the baseline or if loss starts to diverge`

Notifications (task completion, background agents) forward to ntfy / Slack / email after `/labrat:setup`.

---

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
| [Conclusions reviewed against actual artifacts by a fresh-context research peer](plugin/hooks/hooks.json) |
| [Pointer to the launch skill when an ML training job starts](plugin/scripts/launch_context.sh)            |

---

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

---

## Design Principles

1. **Methodology over scripts**. Skills teach the approach, Claude generates code for your specific setup (wandb, neptune, local files, whatever)
2. **Human oversight first**. Claude makes premature claims and jumps to conclusions. Every skill builds in verification checkpoints
3. **Actionable output**. Ranked suggestions with specific fixes, never just a list of findings

---

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
