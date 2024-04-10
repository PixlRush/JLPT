.PHONY: all clean

all: clean

clean:
	latexmk -quiet -C

Compiled/%.pdf: %/main.tex %/*.tex %/*/*.tex
	-latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@