# Research and Experiment Tracker Issues

Use this layout for every GitHub tracker issue that records dataset builds, baseline reproductions, training sweeps, or ablation studies. Keep individual experiment rows in the tracker issue and keep project skills (`SKILL.md`) compact: skills hold reusable know-how, reproduction commands, paths, weight hashes, settled findings, and a champion summary table, never raw wave-by-wave logs.

## Canonical Issue Layout

Every tracker issue follows five sections in exact order:

### 1. Top Reproduction Accordion (`> [!IMPORTANT]` + closed `<details>`)

Start the issue body with a closed reproduction block containing exact code revisions, environment pins, dataset/cache paths, starting weight digests (`sha256` or `md5`), and copy-pasteable training and evaluation commands:

````markdown
> [!IMPORTANT]
> <details>
> <summary><b>How to reproduce</b>: code, environment, data, weights, training and evaluation</summary>
>
> **Code:** branch [`<branch>`](https://github.com/<org>/<repo>/tree/<branch>) ([`<sha7>`](https://github.com/<org>/<repo>/commit/<full-sha>)), scripts in `<path>/` (`train.py`, `eval.py`).
>
> **Environment:** `<venv-path>` (`torch <ver>`, `<key-deps>`).
>
> **Data:** `<host>:<dataset-or-cache-path>` (`<train-count>` train / `<val-count>` val images).
>
> **Starting weights:** `<path>/<weight>.pt` (`sha256:<prefix>`).
>
> ```bash
> # Train
> python train.py --config <cfg> --weights <weight>.pt --device 0,1,2,3
>
> # Evaluate
> python eval.py best.pt --data <data.yaml> --save-json predictions.json
> ```
>
> </details>
````

### 2. Concise Overview Bullets (Never an Unformatted Text Blob)

Immediately below the reproduction accordion, summarize the research question and headline results using 2-3 structured top-level bullets (`- **Goal:**`, `- **Key Findings:**`) with short indented sub-bullets and inline links (`[`sha7`](url)`, `[`#N`](url)`). Never write a wall-of-text paragraph blob.

```markdown
- **Goal:** Compare `<factors>` on `<benchmarks>` against [`#<ref-issue>`](url) `<baseline>` from identical `<init-weights>`.
  - **Architectures & Inits:** `<arch-A>` (`<init-A>`) vs. `<arch-B>` (`<init-B>`).
  - **Ablated Factors:** `<factor-1>`, `<factor-2>`, and `<factor-3>` ([`<sha7>`](url)).
- **Key Findings:**
  - **<Winner / Factor 1> ([`<sha7>`](url)):** Reaches **`<metric>`** (`+<delta>` over `<baseline>`).
  - **<Falsified Factor 2> ([`<sha7>`](url)):** Drops `<metric>` to `<val>` because `<1-line root cause>`.
```

### 3. Top `### Summary` Table (Baselines + Champions)

Place the `### Summary` table right below the overview bullets so readers see the baselines and best runs without opening any accordion:

- Put reference baselines (`(ref)`) first, followed by the champion or leading row of each ablation group.
- Name what changed in plain English (`Model`, `Change`), never internal shortcodes (`E4`, `Q5`, `run-1`).
- Include a `Code` column linking the exact training commit (`[`sha7`](https://github.com/<org>/<repo>/commit/<full-sha>)`) and a `Progress` column (`✅ 25/25`, `🟡 12/25`, `⏹️ 12/25`, `❌`).
- Bold numeric winners within comparable settings. Use `-` for inapplicable cells and `pending` for unmeasured cells on active runs.

```markdown
### Summary

| Model | Change | Code | Progress | Primary Metric | Secondary Metric |
| --- | --- | --- | --- | --- | --- |
| `<baseline>` (ref) | `<default recipe>` | [`<sha7>`](url) | ✅ 25/25 | 37.80 | 57.60 |
| **`<ablation-winner>`** | `<factor change>` | [`<sha7>`](url) | ✅ 25/25 (best ep25) | **38.16** | **58.39** |
```

### 4. Closed `<details>` Ablation Group Sections (Identical Column Schema)

Group all individual runs under `### Ablation Groups` (or `### Trainings` / `### Benchmarks`) into closed `<details>` blocks, one per factor, architecture stage, or evaluation slice:

- **Blank-line rule:** Always keep a blank line after `<summary>...</summary>` and before `</details>`. Without those blank lines GitHub renders tables as raw pipes. Never use `<details open>`.
- **Summary clause:** `<summary><b>1. Group Title</b>: what the block compares and headline takeaway</summary>`.
- **Uniform table schema:** Reuse the exact same metric columns and column order as `### Summary`. Training tables may add `Host: GPUs` and `Run` (linking the W&B run); standalone benchmark tables may add `Eval code` and `Epoch` when post-hoc evaluation code differs from training code.

```markdown
### Ablation Groups

<details>
<summary><b>1. <Group Title></b>: <what this block compares and headline number></summary>

| Model | Change | Host: GPUs | Code | Progress | Primary Metric | Secondary Metric | Run |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **`<run-name>`** | `<change>` | `<host>: 0,1` | [`<sha7>`](url) | ✅ 25/25 | **38.16** | **58.39** | [W&B](url) |

</details>
```

### 5. `### Comments` Index & Figures

- List deep-dive root-cause analyses, code audits, or overflow tables (when an issue approaches GitHub's 65,536-character limit) under `### Comments` at the bottom, each with a linked title and a one-line summary.
- Generate comparison or Pareto figures using the [CVPR plotting guide](../../paper-write/references/cvpr.md) and [`plots.py`](../../paper-write/assets/cvpr/plots.py) (neutral gray baselines, Okabe-Ito accents, direct labels, no top/right spines). Upload figures inline via `gh issue edit <N> --body-file <file> --attach <figure.png>` (`gh >= 2.99.0`), never by committing PNGs to git branches.

## Live-Update Protocol

1. **Fetch live body without trailing-newline drift:**
   ```bash
   gh issue view <N> --repo <owner>/<repo> --json body -q .body > /tmp/issue_orig.md
   ```
2. **Patch in place and verify:** Update rows, progress, and summary winners in Python. Verify that no existing run row was dropped and that the body contains no em-dashes, en-dashes, semicolons, section signs, `<details open>`, or unformatted paragraph blobs.
3. **Push once and confirm round-trip:**
   ```bash
   gh issue edit <N> --repo <owner>/<repo> --body-file /tmp/issue_new.md
   ```
