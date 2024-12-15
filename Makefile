.PHONY: all clean

# All targets for main.texs to make Compiled/*.pdfs
PDF-TARGETS := Compiled/Full.pdf $(shell find . -name "main.tex" | grep -v "\./main\.tex" | sed -E "s/\.?\/?([a-zA-Z0-9]*)(\/.*)*\/main.tex/Compiled\/\1.pdf/")

all: $(PDF-TARGETS) clean

# Cleaning Up
clean:
	@echo "\n--==Cleaning Up==--\n"
	latexmk -quiet -C

# Compiled PDF creation
Compiled/Full.pdf: main.tex comp.tex preamble.tex title.tex
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet --shell-escape -synctex=1 $<
	mv main.pdf $@

# Generalized PDF Creation
Compiled/%.pdf: %/main.tex preamble.tex title.tex %/**.tex
	@echo "--==Compiling $@==--"
	latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@