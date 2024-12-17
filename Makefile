.PHONY: all anki voice-lines clean purge

# All targets for main.texs to make Compiled/*.pdfs
PDF-TARGETS := Compiled/Full.pdf $(shell find . -name "main.tex" | grep -v "\./main\.tex" | sed -E "s/\.?\/?([a-zA-Z0-9]*)(\/.*)*\/main.tex/Compiled\/\1.pdf/")
# Find all targets for a voice-lines makefile
VOICE-TARGETS := $(shell find . -name Makefile | grep "voice-lines/Makefile")


all: $(PDF-TARGETS) anki voice-lines clean

# Cleaning Up
clean:
	@echo "\n--==Cleaning Up==--\n"
	latexmk -quiet -C

# Purge all
purge:
	@echo "\n--==Purging==--\n"
	latexmk -quiet -C
	rm ./Compiled/*.pdf
	@# Call down to purge voice-lines
	@for MFILE in $(VOICE-TARGETS); do echo "\n-=Purging $$MFILE=-\n"; make -C $${MFILE%/*} purge; done

# Compiled PDF creation
Compiled/Full.pdf: main.tex comp.tex preamble.tex title.tex $(shell find . -name "*.tex" | grep "N./.*\.tex")
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet --shell-escape -synctex=1 $<
	mv main.pdf $@

# Generalized PDF Creation
Compiled/%.pdf: %/main.tex preamble.tex title.tex %/**.tex
	@echo "\n--==Compiling $@==--\n"
	latexmk -f -xelatex -interaction=nonstopmode -quiet -synctex=1 $<
	mv main.pdf $@

# Voice Line Creation
voice-lines: $(VOICE-TARGETS)
	@# Automatically finds file named Makefile
	@-for MFILE in $(VOICE-TARGETS); do echo "\n-=Making $$MFILE=-\n"; make -C $${MFILE%/*}; done

anki: Anki/Makefile
	@echo "\n-=Making ./Anki/=-\n"
	@make -C Anki