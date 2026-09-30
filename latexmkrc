$pdf_mode = 5;
$pdfxelatex = "xelatex -synctex=1 --shell-escape -interaction=nonstopmode -file-line-error %O %S";
$bibtex_use = 1.5;

# Same search paths as the Makefile, so latexmk (and CI) use style/IEEEtran.cls
# and friends instead of silently falling back to the TeX Live copies.
ensure_path('TEXINPUTS', './style//');
ensure_path('BSTINPUTS', './style//');
