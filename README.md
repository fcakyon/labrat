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

Every tool gets the same 11 skills. The research peer review and notifications run in Claude Code only. Paper search needs [Paper Search CLI](https://github.com/fcakyon/paper-search-cli) (uv, Python 3.10+, [setup](plugin/skills/literature-research/references/paper-search.md)), nothing else does. Optional: `/labrat:setup` shows what it detected and turns on extras like notifications to ntfy, Slack or email, the command allowlist and LaTeX.

## Why

AI agents make research mistakes that cost weeks of compute. Real ones from my sessions:

- It read "done?" as "dont?" and started uploading thousands of files.
- It restarted a 50-hour training job without diffing the config against the reference run. Three days lost.
- It killed an experiment over a proxy metric that had not converged, before the downstream eval could show the real result.
- It ran `rm -rf` on a path it remembered wrong and deleted local checkpoints.

The skills teach the method, not a script, so the agent writes code for your setup (wandb, neptune, local files) and stops to check the evidence before it claims a result.

## Skills

A skill starts when you describe its task, or run it as `/labrat:<skill>`.

| Say | Skill |
| --- | --- |
| "find related papers on X", "find gaps in the literature on X" | [literature-research](plugin/skills/literature-research/SKILL.md) |
| `/labrat:reproduce arxiv 2508.12345` | [reproduce](plugin/skills/reproduce/SKILL.md), from the paper to replication runs |
| "design an ablation study" | [experiment-design](plugin/skills/experiment-design/SKILL.md) |
| "launch the new training run" | [launch](plugin/skills/launch/SKILL.md), with a pre-flight checklist |
| "why is my loss diverging?" | [debug](plugin/skills/debug/SKILL.md), evidence before fixes |
| "compare run alpha to baseline" | [compare](plugin/skills/compare/SKILL.md), at the same epoch |
| "analyze dataset bias" | [dataset-curation](plugin/skills/dataset-curation/SKILL.md) |
| "check my numbers match the code", "verify my BibTeX", "prepare code for release" | [paper-check](plugin/skills/paper-check/SKILL.md) |
| "review my methods section", "set up LaTeX for CVPR" | [paper-write](plugin/skills/paper-write/SKILL.md) |
| "what will reviewers ask?", "pick my strongest ablations" | [rebuttal](plugin/skills/rebuttal/SKILL.md) |
| `/labrat:setup` | [setup](plugin/skills/setup/SKILL.md) |

In Claude Code, a fresh-context research peer [hook](plugin/hooks/claude-hooks.json) checks each conclusion against the actual artifacts and sends you to the matching skill, like the launch checklist before a run.

For long runs, pair it with `/loop 30m check experiment logs, notify me if metrics beat the baseline or if loss starts to diverge`.

## Star history

<a href="https://www.star-history.com/#fcakyon/labrat&Date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=fcakyon/labrat&type=Date&theme=dark" />
    <img alt="Lab Rat star history" src="https://api.star-history.com/svg?repos=fcakyon/labrat&type=Date" />
  </picture>
</a>

## Contributors

<a href="https://github.com/fcakyon/labrat/graphs/contributors">
  <img alt="Contributors" src="https://contrib.rocks/image?repo=fcakyon/labrat" />
</a>

MIT license.
