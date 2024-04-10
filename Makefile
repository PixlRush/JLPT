.PHONY: all clean

all: Compiled/Full.pdf Compiled/Primitives.pdf clean

clean:
	latexmk -quiet -C

Compiled/Full.pdf: main.tex preamble.tex *.tex */*.tex
	-latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@

Compiled/%.pdf: %/main.tex preamble.tex %/*.tex %/*/*.tex
	-latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@