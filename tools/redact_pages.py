"""Rasterize a PDF page, black out OCR lines matching patterns, write a 1-page PDF.
Usage: redact_pages.py <in.pdf> <page> <out_page.pdf> <regex> [<regex>...]
Prints the lines blacked out (text as OCR'd) and their boxes."""
import sys, re, subprocess, csv, tempfile, os
from PIL import Image, ImageDraw
src, page, out = sys.argv[1], int(sys.argv[2]), sys.argv[3]
pats = [re.compile(p, re.I) for p in sys.argv[4:]]
tmp = tempfile.mkdtemp()
subprocess.run(["pdftoppm", "-r", "300", "-png", "-f", str(page), "-l", str(page), src, os.path.join(tmp, "pg")], check=True, stderr=subprocess.DEVNULL)
png = [os.path.join(tmp, f) for f in os.listdir(tmp) if f.endswith(".png")][0]
subprocess.run(["tesseract", png, os.path.join(tmp, "ocr"), "-l", "fra+eng", "tsv"], check=True, stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
lines = {}
with open(os.path.join(tmp, "ocr.tsv"), newline="") as fh:
    for r in csv.DictReader(fh, delimiter="\t", quoting=csv.QUOTE_NONE):
        if r["level"] != "5" or not r["text"].strip(): continue
        key = (r["block_num"], r["par_num"], r["line_num"])
        lines.setdefault(key, []).append(r)
img = Image.open(png).convert("RGB"); draw = ImageDraw.Draw(img); n = 0
for key, words in lines.items():
    text = " ".join(w["text"] for w in words)
    if not any(p.search(text) for p in pats): continue
    # keep a leading label such as "A:" / "À :" visible, black out the rest of the line
    keep = 0
    if re.fullmatch(r"[AÀ]\s*:?", words[0]["text"]) or (len(words) > 1 and words[0]["text"] in ("A", "À") and words[1]["text"] == ":"):
        keep = 1 if re.fullmatch(r"[AÀ]\s*:", words[0]["text"]) else (2 if len(words) > 1 and words[1]["text"] == ":" else 1)
    ws = words[keep:]
    if not ws: continue
    l = min(int(w["left"]) for w in ws) - 6; t = min(int(w["top"]) for w in ws) - 6
    r_ = max(int(w["left"]) + int(w["width"]) for w in ws) + 6; b = max(int(w["top"]) + int(w["height"]) for w in ws) + 6
    draw.rectangle([l, t, r_, b], fill="black"); n += 1
    print(f"  blacked out line: {text!r}  box=({l},{t},{r_},{b})")
img.save(out, "PDF", resolution=300.0)
print(f"  {n} box(es) drawn; wrote {out}")
