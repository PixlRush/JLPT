.PHONY: all clean

all: Compiled/Full.pdf clean

clean:
	@echo "\n--==Cleaning Up==--\n"
	latexmk -quiet -C

Compiled/Full.pdf: main.tex preamble.tex title.tex
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@
