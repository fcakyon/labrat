# CVPR paper writing and presentation

Use this reference when writing or revising a CVPR main-conference or workshop paper. Read the current source, rendered PDF, figure/table generators and project instructions first. Keep the paper's scientific question and verified evidence as the basis for presentation decisions.

## Check the year and track

Follow the target year's official author guidelines and author kit. Workshop paper limits belong to that workshop, not to the call for workshop proposals. Keep mandatory requirements separate from design choices observed in accepted papers.

As checked on 2026-11-15, the [CVPR 2027 author guidelines](https://cvpr.thecvf.com/Conferences/2027/AuthorGuidelines) limit main text, figures and tables to eight pages. Extra pages may contain cited references and the mandatory anonymous LLM Usage Statement. Recheck the rules before submission, including the required disclosure contents. Do not apply these details to another year without verification.

Count main content after flushing pending floats. A combined PDF containing references and supplementary material can exceed eight pages even when the main body fits. Record the main-body boundary and supplementary start, rather than reporting only the PDF's total page count. Do not reduce margins or body fonts to fit more content.

## Make the argument easy to follow

Align the title, abstract, teaser, introduction and conclusion with one central question and its strongest supported finding. Introduce the problem, the tested intervention and what the evidence shows. A list of architecture changes or model scores does not explain the contribution.

A useful abstract states the problem, approach, main result and its practical limits. Include only the numbers needed to convey that result. A short abstract can be sufficient. Do not treat an abstract length, sentence count or contribution-list format observed in a few accepted papers as a venue requirement or a predictor of acceptance.

Organize results around scientific questions. Lead with the experiments that answer the central question, followed by the controls needed to interpret them. Open each results paragraph with its finding, then give the evidence and interpretation. Keep necessary protocol and metric definitions in the main text.

Use direct wording and define technical terms on first use. For example, use "extra predictions" when that is the intended meaning of "spurious", and distinguish invalid model output from a faulty input image. State the measured result without inventing a cause. Overlapping confidence intervals do not demonstrate equivalence, and single-run gains do not establish repeatability.

## Design the first-page teaser

Choose one visual argument that a reader can understand quickly. A mechanism schematic, matched result plot or qualitative comparison can work. Multiple panels help when they answer the same question. Do not merge unrelated figures simply to save space.

Show the intervention or failure mode alongside its matched evidence. Identify synthetic illustrations as schematics. Check that transformations preserve what the schematic claims: cyclic shifts and reversed traversal preserve a polygon ring, while arbitrary vertex permutations can change its mask.

Match the model, data, budget, checkpoint policy and scorer for a claimed improvement. Plot paired-difference intervals on a delta axis, not around absolute score endpoints. Do not infer a direct treatment-versus-control interval from two separate intervals against a shared baseline. Keep tasks and views with different taxonomies separate.

Inspect the rendered first page. A `figure*` inside the introduction may float to page two. Reuse the title-area mechanism supported by the current template, then check the named and anonymous builds. Avoid global output-routine changes just to place a teaser.

## Keep tables simple

Use top, header, block and bottom horizontal rules. A few thin separators usually make related rows easier to scan than repeated full-width group headings. Keep model and condition identifiers in the row labels, optionally showing a model name only on the first row of its block. Short condition labels can help when a rule alone is ambiguous.

Use grouped column headers for shared datasets, scales or protocols. State units and whether higher or lower is better. Keep numeric precision consistent with the measurement. Move repeated constants and long protocol descriptions into the caption or methods.

Bold the declared descriptive best values within a comparable block, including displayed ties. Use a separate symbol, explained in the caption, for a selected configuration that does not win every metric. Do not bold its row name as though all its values were best. Avoid ranking unmatched budgets or cohorts as a fair competition. If exploratory rows with unequal exposure share a block, state that bold is descriptive and disclose the exposure differences.

Related small ablations can share a full-width table with panels if each panel remains legible. Keep them separate when merging requires tiny text or makes the caption difficult to follow. A task-summary table can show absolute scores and deltas, with detailed protocols and timing in supporting tables. Update existing generators and verify that the measured values and provenance survive presentation changes.

## Arrange figures and supporting material

Put the method overview near its first explanation and key results near the text discussing them. Inspect final float order, first references, legends, captions and page breaks. Check both full-page thumbnails and close crops at the intended printed size.

Prefer vector plots and consistent fonts, colors, units and model labels. State hardware and batch settings for timing comparisons. Keep cross-session adjustments distinct from measured latency. Label error-rate denominators, especially when image-level invalid-output rates appear beside instance-level errors.

Keep full-width task or qualitative visuals in the main paper when they supply central evidence. Move an exploratory pilot or a redundant visualization when its role is supporting. Do not automatically shrink every qualitative figure to one column.

Cut repeated text and duplicate plots before shrinking fonts. Keep evidence for the stated contributions, necessary controls and material limitations in the main paper. Supporting derivations, detailed sweeps and additional diagnostics can go to supplementary material with explicit references. Moving a negative result must not remove its implication from the main narrative. Check the target year's supplementary rules, including restrictions on improved methods, new results and corrected submissions.

## Verify the compiled artifact

Use the project's existing LaTeX pipeline from [latex.md](latex.md), with separate output directories for named and anonymous builds. Resolve missing citations and references, inspect overflow and clipping, and check embedded fonts and author visibility. Preserve unique supplementary section, table, figure and hyperlink numbering.

For separate main and supplementary exports, split at the verified boundary and inspect both PDFs. Keep the LLM Usage Statement anonymous and disclose only tool use that is known. Identify missing disclosure information before submission rather than inventing a complete account.

When the requested workflow includes a hosted editor, verify its own compiled PDF after syncing the reviewed source. Local compilation alone does not establish the hosted layout or pagination. Presentation work does not authorize new experiments, external publication or submission.

## Published examples

These examples illustrate design choices, not universal CVPR conventions or evidence that a layout increases acceptance probability.

- [How Useful Are Vision Foundation Model Features for Out-of-the-Box Disease Progression Prediction?](https://openaccess.thecvf.com/content/CVPR2026W/CV4Clinic2026/papers/Demir_How_Useful_Are_Vision_Foundation_Model_Features_for_Out-of-the-Box_Disease_CVPRW_2026_paper.pdf), CVPR Workshops 2026, Tables 4 and 5: thin separators, short alignment-condition labels and bold values within the stated settings.
- [Attention Consistent Longitudinal Medical Visual Question Answering Guided by Vision Foundation Models](https://openaccess.thecvf.com/content/CVPR2026W/PHAROS-AIF-MIH/papers/Wu_Attention_Consistent_Longitudinal_Medical_Visual_Question_Answering_Guided_by_Vision_CVPRW_2026_paper.pdf), CVPR Workshops 2026, Table 1: a horizontal rule separates comparator methods from the proposed method.
