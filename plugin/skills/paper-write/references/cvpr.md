# CVPR writing and layout

Use these patterns with the paper's current author kit. Build instructions are in [latex.md](latex.md).

## Rules and message

- Check the target year and track. Workshop paper limits differ from workshop-proposal limits.
- [CVPR 2027](https://cvpr.thecvf.com/Conferences/2027/AuthorGuidelines), checked 2026-11-15: eight main-content pages, including figures and tables. Cited references and the mandatory anonymous LLM Usage Statement may occupy extra pages. Recheck before submission.
- Align title, abstract, teaser and conclusion around one supported finding. Abstract: problem, approach, result, limitation. Include only useful, traceable numbers.
- Organize results by question, with findings first and the necessary controls beside them. Define technical terms. Prefer "extra predictions" and "invalid output" when those are the scorer's meanings.
- Match model, cohort, budget, checkpoint policy and scorer before claiming improvement. Keep paired-difference intervals on a delta axis. Overlapping intervals do not establish equivalence.

## First-page teaser

- Show one visual argument. Combine panels only when they answer the same question. Label synthetic illustrations as schematics.
- A `figure*` inside the introduction may land on page two. If the current kit uses `\@maketitle`, this preamble hook places a teaser in its full-width title area. It needs `graphicx` and `capt-of`.

```latex
\usepackage{graphicx,capt-of}
\makeatletter
\g@addto@macro\@maketitle{%
  \par\centering
  \includegraphics[width=\textwidth]{fig/teaser.pdf}\par
  \captionof{figure}{Task, cohort, comparison and main observation.}
  \label{fig:teaser}
}
\makeatother
```

- Inspect page one in named and anonymous builds. Keep the method overview near its explanation. Preserve readable full-width task visuals when they supply central evidence.

## Tables

- Prefer thin rules to repeated group-heading rows. Use short row labels, grouped column headers, explicit units and consistent precision. Timing captions state hardware and batch size.
- Bold declared numeric winners within comparable settings, including ties. Mark a selected configuration separately. If exposure differs, disclose it and call maxima descriptive.
- Merge related ablations only while every panel stays legible. Update the generator and verify values and provenance remain unchanged.

Example with illustrative values, using `booktabs`:

```latex
\begin{table}[t]
\centering
\begin{tabular}{lrr}
\toprule
Model & AP $\uparrow$ & ms $\downarrow$ \\
\midrule
Baseline & 48.0 & 3.1 \\
\midrule
Variant A$^{\dagger}$ & 47.8 & \textbf{2.8} \\
Variant B & \textbf{49.2} & 3.4 \\
\bottomrule
\end{tabular}
\caption{Illustrative matched comparison. Bold: best per column.
$^{\dagger}$Selected configuration.}
\label{tab:comparison}
\end{table}
```

## Main paper and supplement

- Keep headline evidence, essential controls and material limitations in the main paper. Move detailed sweeps, redundant plots and supporting diagnostics with explicit references. Preserve the implication of negative results.
- Cut repetition before shrinking fonts. Do not change margins to fit. Check the year's restrictions on supplementary results.
- Flush floats before counting main pages. For a combined document using `hyperref`, adapt this boundary and numbering pattern. Reuse the existing bibliography pipeline at the indicated point.

```latex
\clearpage
\typeout{MAIN_CONTENT_PAGES=\number\numexpr\value{page}-1\relax}
% References and required disclosures go here.
\clearpage
\appendix
\setcounter{table}{0}
\setcounter{figure}{0}
\renewcommand{\thetable}{S\arabic{table}}
\renewcommand{\thefigure}{S\arabic{figure}}
\renewcommand{\theHtable}{supp.\arabic{table}}
\renewcommand{\theHfigure}{supp.\arabic{figure}}
\typeout{SUPPLEMENT_START_PAGE=\thepage}
\input{supplement}
```

- Verify main-content pages separately from total PDF pages. Resolve missing references, clipping and overflow. Check fonts, anonymity, float order and exported PDF boundaries. Disclose actual tool use.
- If syncing a hosted editor is requested, inspect its compiled PDF too. Layout work does not authorize submission or new experiments.

## Published examples

These illustrate choices, not mandatory conventions or predictors of acceptance:

- [CV4Clinic 2026, Tables 4–5](https://openaccess.thecvf.com/content/CVPR2026W/CV4Clinic2026/papers/Demir_How_Useful_Are_Vision_Foundation_Model_Features_for_Out-of-the-Box_Disease_CVPRW_2026_paper.pdf): thin rules, short condition labels, bold within settings.
- [PHAROS-AIF-MIH 2026, Table 1](https://openaccess.thecvf.com/content/CVPR2026W/PHAROS-AIF-MIH/papers/Wu_Attention_Consistent_Longitudinal_Medical_Visual_Question_Answering_Guided_by_Vision_CVPRW_2026_paper.pdf): one rule separates comparator methods from the proposed method.
