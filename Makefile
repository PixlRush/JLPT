.PHONY: all clean

all: Compiled/Full.pdf

# Cleaning Up
clean:
	@echo "\n--==Cleaning Up==--\n"
	latexmk -quiet -C

# Compiled PDF creation
Compiled/Full.pdf: main.tex comp.tex preamble.tex title.tex
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet --shell-escape -synctex=1 $<
	mv main.pdf $@
