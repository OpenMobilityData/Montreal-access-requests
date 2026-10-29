# Montréal access requests

Records released by the Ville de Montréal and its boroughs under Quebec's *Act respecting Access to documents held by public bodies and the Protection of personal information* (CQLR, c. A-2.1), gathered here with their provenance so that anyone can read what was released, when and to whom, and check any work drawn from them.

Two kinds of material are kept:

- **Request folders** (`<file no.>/`): one folder per access-request file number. The releases collected so far were made to other requesters and obtained by the author from the City's proactive-disclosure portal; the folder README says so for each.
- **Proactive-disclosure bundles** (`proactive-disclosure/<theme>/`): responses the City and its boroughs published on the portal ([*Diffusion proactive – Documents remis des demandes d'accès à l'information*](https://donnees.montreal.ca/dataset/diffusion-proactive-acces-information)), grouped by theme, each with the portal's inventory row and the date downloaded.

Requests concerning the Terrebonne bike lane in Côte-des-Neiges–Notre-Dame-de-Grâce are kept in the separate repository [`Terrebonne-access-requests`](https://github.com/OpenMobilityData/Terrebonne-access-requests).

## How the repository is organized

```
<file no.>/                    one folder per access-request file number
    README.md                  provenance, contents, what is public where
    raw/                       documents as released, under their portal file names
    derived/                   anything made from the release: analyses, scripts, figures (marked draft where they are drafts)
proactive-disclosure/          portal downloads grouped by theme
    budget/  cycling/          one PDF per portal entry, under the portal file name; README quotes each inventory row
    inventory/                 dated copies of the City's inventory of the portal (CSV)
tools/                         scripts used to prepare files for publication (the redaction script)
```

Rules:

- Nothing in `raw/` or in a proactive-disclosure folder is modified, with one exception: personal information of a private requester that a release left visible or recoverable is redacted by the repository owner. Each such file is listed in its folder README and in the table below, with the method; the redacted copies are images of the affected pages (or, for a hidden link, the link removed) so that the redaction cannot be undone.
- Every derived file names its source. Drafts are marked as drafts, with their date.
- Decisions of the Commission d'accès à l'information (CAI) are cited by neutral citation and docket, not reproduced.

## Requests

| File no. | Public body | Answered | Subject | How obtained | Folder |
|---|---|---|---|---|---|
| 2022-1447 | Ville de Montréal, Service du greffe | 2022-07-19, with further documents during CAI review 1028927-J (2022-11 – 2023-06) | How the central city determines the operating budgets of the Sud-Ouest, Côte-des-Neiges–Notre-Dame-de-Grâce and Saint-Laurent boroughs since 2017: the 2014 *Réforme du financement des arrondissements* documents, the City's Excel model of the transfers 2017–2022, and related tables | Request by a resident; downloaded by the author from the proactive-disclosure portal on 2025-02-18 | [`2022-1447/`](2022-1447/) |
| 2021_464 | Ville de Montréal, Service du greffe | 2021-09-02 | The City's legal fees in the Sue Montgomery matter (CMQ proceedings, Superior Court files 500-17-111893-205, 500-17-114125-209, 500-17-117103-211), by law firm; another resident's request | Downloaded by the author from the portal on 2026-10-21 (inventory row Demande2021_464) | [`2021-464/`](2021-464/) |
| 2022-1449 | Ville de Montréal | not shown in the release | Borough borrowing by-laws and debt balances, 2005–2020 (three files, dated 2022-04-06) | Downloaded by the author from the portal on 2025-02-18, with the 2022-1447 files | [`2022-1449/`](2022-1449/) |

Proactive-disclosure bundles: [`proactive-disclosure/budget/`](proactive-disclosure/budget/) (two Côte-des-Neiges–Notre-Dame-de-Grâce releases on borough finances, including 2022-131, the borough's answer to the revenue part of the same resident's March 2022 requests), [`proactive-disclosure/cycling/`](proactive-disclosure/cycling/) (nine releases on the cycling network and its cost, 2021–2024), [`proactive-disclosure/inventory/`](proactive-disclosure/inventory/).

### Redactions by the repository owner

| File | What was redacted | Method |
|---|---|---|
| `2022-1447/raw/O - 1 1 Demande 23-03-2022 Budget 3 arrondissements.pdf` | Requester's name and home address (signature block) | Page rasterized at 300 dpi, lines blacked out; the file is now an image |
| `2022-1447/raw/O - 1 2 Réponse et documents 19-07-2022.pdf` | Requester's e-mail address on the "À :" line of the City's e-mail (p. 1) | Page 1 rasterized at 300 dpi and blacked out; pp. 2–258 unchanged |
| `proactive-disclosure/budget/3-2022-131.pdf` | A hidden `mailto:` link to the requester's e-mail address under the borough's black box (p. 1); the visible page was already redacted by the borough | Link target blanked; text and page images unchanged |

The script and commands are in [`tools/`](tools/). The City's copies of these files are not redacted in these places.

## Provenance and use

The documents are reproduced as released, including the City's and boroughs' own redactions. Names and work contact details of public officials appear as released. The releases are public records; the inventory CSVs are City of Montréal open data (CC BY 4.0). The releases themselves (`raw/`) keep their status as public records and are not licensed here. The READMEs and the contents of the `derived/` folders are published under CC BY 4.0 ([`LICENSE`](LICENSE)); code under the MIT licence ([`LICENSE-CODE`](LICENSE-CODE)).

Quotations from these documents in other work should cite the file number, the file name and the PDF page, e.g. "2022-1447, `O - 1 4 Présentation_  DSA et CD - MAI 2019.pdf`, p. 6".

### Edit history

Everything in this repository was written in the open. The complete edit history of every file is public through the [commit log](https://github.com/OpenMobilityData/Montreal-access-requests/commits/main) and the diffs; each change can be traced to the commit that made it, with the reason given in the commit message. The files in `2022-1447/` were first published, without provenance, in the repository `OpenMobilityData/Parametric` (February 20, 2025); this repository superseded it, and it was deleted on October 17, 2026.

## Use of AI

Much of the code and many of the drafts in this repository were produced with an AI assistant, Anthropic's Claude, in interactive sessions directed by the author. The author chose the questions, supplied the sources, reviewed every output, and checked every quotation, page reference and figure against the documents; the author alone is responsible for the content. Commits to which the assistant contributed name it as co-author, so the division of work is visible in the history, and errors found in its work are corrected in the open like any other. Nothing in `raw/` is edited by anyone, human or machine. The practice follows the principles of the European Commission's « Living guidelines on the responsible use of generative AI in research » (Directorate-General for Research and Innovation with the European Research Area Forum, first published March 20, 2024 and updated since; [document page](https://research-and-innovation.ec.europa.eu/document/2b6cf7e5-36ac-41cb-aab5-0d32050143dc_en)): the researcher remains responsible for the output, the use of the tool is disclosed, sources and facts are verified, privacy and third-party rights are respected, and the tool is never an author.

Everything is open to review: all source code, documents and data in this repository are publicly visible, as is the complete change log of every file. Anyone is welcome to read any of it and check it for errors and omissions. Anyone with a concern is welcome to open an issue on GitHub; every issue submitted is publicly visible, as is its answer.

## Related

- [`Terrebonne-access-requests`](https://github.com/OpenMobilityData/Terrebonne-access-requests) — requests concerning the Terrebonne bike lane.
- [`Terrebonne-open-sources`](https://github.com/OpenMobilityData/Terrebonne-open-sources) — public documents on the lane obtained from open sources rather than under the Act.

## About the author

The repository is maintained by Rick Hoge, a resident of Côte-des-Neiges–Notre-Dame-de-Grâce. He works as a data scientist and is a professor in the Faculty of Medicine at McGill University. The work in this repository is personal: it was done as a resident, on his own time, from public records, and represents no position of McGill University or of any other organization; the affiliation is given for identification only. Corrections are welcome through the repository's issue tracker.
