.PHONY: all clean

all: Compiled/Full.pdf Compiled/Primitive.pdf clean

clean:
	@echo "\n--==Cleaning Up==--\n"
	latexmk -quiet -C
	rm version.tex
	rm -rfd svg-inkscape

version.tex: versioning.sh
	@echo "\n--==Generating Version Tag==--"
	@bash versioning.sh
	@cat version.tex

Compiled/Full.pdf: main.tex preamble.tex title.tex version.tex
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet --shell-escape -synctex=1 $<
	mv main.pdf $@

Compiled/%.pdf: %/main.tex preamble.tex title.tex version.tex %/*.tex %/*/*.tex
	@echo "--==Compiling $@==--"
	latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@
