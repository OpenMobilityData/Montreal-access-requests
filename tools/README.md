# Tools

## `redact_pages.py` — black out lines on a PDF page

Rasterizes one page of a PDF at 300 dpi, locates the text lines matching one or more regular expressions by OCR, draws an opaque black box over each matching line (keeping a leading "A :" / "À :" label visible), and writes the page as a one-page image PDF. Because the output page is an image, nothing remains under the boxes.

```
python3 redact_pages.py <in.pdf> <page> <out_page.pdf> <regex> [<regex>...]
```

Requires Python 3 with Pillow, `pdftoppm` (Poppler), `tesseract` (with the `fra` and `eng` language data) and, to put a page back into a longer file, `qpdf`. The script prints each line it blacks out with its box.

It was used for the two files of [`2022-1447/raw/`](../2022-1447/raw/) that showed the requester's identity (October 17, 2026). The patterns were the requester's name, street address and e-mail address; they are not reproduced here, since they would themselves identify the requester.

- `O - 1 1 Demande 23-03-2022 Budget 3 arrondissements.pdf` (one page): the output page is the whole file.
- `O - 1 2 Réponse et documents 19-07-2022.pdf` (258 pages): page 1 was redacted and put back in place of the original page 1, keeping pages 2–258 unchanged (equivalent commands):

  ```
  python3 redact_pages.py original.pdf 1 page1.pdf '<pattern>'
  qpdf original.pdf --pages page1.pdf 1 original.pdf 2-z -- redacted.pdf
  ```

Checks made on the results: no text layer on the replaced pages; no identifier in the decompressed PDF bytes; OCR of the redacted pages finds none; visual inspection of both pages.

## Removing a hidden link: `proactive-disclosure/budget/3-2022-131.pdf`

The borough's portal copy kept a `mailto:` link annotation to the requester's e-mail address under its black box on page 1. The link target was blanked with `qpdf`, leaving everything else in place:

```
qpdf --qdf --object-streams=disable 3-2022-131.pdf q.pdf
# in q.pdf, replace the annotation's  /URI (mailto:…)  with  /URI ()
fix-qdf q.pdf > q_fixed.pdf
qpdf --object-streams=generate --compress-streams=y q_fixed.pdf 3-2022-131.pdf
```

Checks: `qpdf --check` reports no errors; `pdftotext` output of all ten pages identical to the depot copy; each page rendered identically; no identifier in the decompressed bytes.

## Checking a whole folder

Before publication every file in the repository was searched for the requester's identifiers in the raw bytes, in every decompressed PDF stream (as 8-bit and UTF-16 text) and in every part of each `.xlsx`, as well as by text extraction and OCR of the pages with no usable text layer.

---

*Use of AI: this README and the derived files beside it were prepared with an AI assistant under the author's direction and review, and checked against the documents; see the repository's [Use of AI statement](../README.md#use-of-ai).*
