# 2022-1447 — derived work (drafts, February 2025)

**Status: unreviewed drafts.** These files were made by the author in February 2025 while reading the Excel model released under 2022-1447 ([`../raw/O - 1 3 Modèle_RFA_2017-2022_DAI_20221130.xlsx`](<../raw/O - 1 3 Modèle_RFA_2017-2022_DAI_20221130.xlsx>)). They are published as they were left, for the record, and have not been checked against the release. Their figures, units and interpretations should not be cited without checking them against the spreadsheet; for example, the parameter table in `parametric_budget_model2` gives CDN-NDG an area of 85,409 hectares, which cannot be right as stated. The released documents in [`../raw/`](../raw/) are the reference.

| File | Date | Kind | Content |
|---|---|---|---|
| [`latex/MTL_Parametric_Budget.tex`](latex/MTL_Parametric_Budget.tex), [`.pdf`](latex/MTL_Parametric_Budget.pdf) | 2025-02-20 | Draft note | "Analysis of the City of Montreal's Parametric Budget Model": a first general description, with no figures from the spreadsheet |
| [`latex/parametric_budget_model.tex`](latex/parametric_budget_model.tex), [`.pdf`](latex/parametric_budget_model.pdf) | 2025-02-20 | Draft note | "Parametric Budget Model for Montreal Boroughs": the general transfer formula and a worked 2017 example for CDN-NDG |
| [`latex/parametric_budget_model2.tex`](latex/parametric_budget_model2.tex), [`.pdf`](latex/parametric_budget_model2.pdf) | 2025-02-21 | Draft note (stamped DRAFT) | "Analysis of Montreal's Parametric Budget Model for Borough Transfers, 2017–2022": components of the model, year-by-year calculation for CDN-NDG, comparison with Saint-Laurent and Sud-Ouest, parameter tables, transfer diagram. The source `\input`s a local preamble file not in the repository; the PDF is the version compiled on that date |
| [`latex/Montreal_Budget_Transfer_DAG.png`](latex/Montreal_Budget_Transfer_DAG.png) | 2025-02-21 | Figure | The diagram included by `parametric_budget_model2.tex` |
| [`matlab/parametric_budget_model.m`](matlab/parametric_budget_model.m) | 2025-02-20 | MATLAB script | Replication of the spreadsheet's transfer calculation for CDN-NDG, Saint-Laurent and Sud-Ouest, 2017–2022, with the inputs copied from its sheets, and a comparison of the results with the spreadsheet's values |
| [`matlab/parametric_budget_model2.m`](matlab/parametric_budget_model2.m) | 2025-02-21 | MATLAB script | Simplified version of the same replication |
| [`matlab/budget_dag.m`](matlab/budget_dag.m) | 2025-02-21 | MATLAB script | Directed acyclic graph of the transfer calculation; writes `Montreal_Budget_Transfer_DAG.png/.svg` |
| [`matlab/budgete_dag2.m`](matlab/budgete_dag2.m) | 2025-02-21 | MATLAB script | Fuller graph for a representative year (2020); writes the `Comprehensive`, `Grouped` and `Simplified` diagrams |
| [`figures/`](figures/) | 2025-02-21 | Figures | Twelve diagrams of the transfer calculation (11 PNG, 1 SVG). The per-year diagrams (`…_DAG_2017.png` to `…_DAG_2022.png`) and `…_Complete_DAG.png` were made by a version of the scripts that was not kept |

Not included: the 257-page split of O-1-2 that was in the earlier `Parametric` repository (pages 2–258 of [`../raw/O - 1 2 Réponse et documents 19-07-2022.pdf`](<../raw/O - 1 2 Réponse et documents 19-07-2022.pdf>), re-saved as a separate file), and the author's working copy of the Excel model.
