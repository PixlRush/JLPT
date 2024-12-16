.PHONY: all purge

all: $(shell echo N{1..5}/vocab/anki-deck.csv) $(shell echo N{1..5}/vocab/voice-lines/voice-lines.txt)

purge:
	-rm $(shell find . -name "vocab-deck.csv" | grep "N./vocab-deck\.csv")
	-rm $(shell find . -name "voice-lines.txt")

N%/vocab/anki-deck.csv: Sources/yomitan-jlpt-vocab/original_data/n%.csv
	@echo "Making $@"
	@python3 ./make-vocab-decks.py $< $@
	@echo "Done"

N%/vocab/voice-lines/voice-lines.txt: N%/vocab/anki-deck.csv
	@echo "Making $@"
	@python3 ./make-requirements-list.py $< $@
	@echo "Done"