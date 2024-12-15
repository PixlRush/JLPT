.PHONY: all purge

all: $(shell echo N{1..5}/vocab-deck.csv)

purge:
	-rm $(shell find . -name "vocab-deck.csv" | grep "N./vocab-deck\.csv")

N%/vocab-deck.csv: Sources/yomitan-jlpt-vocab/original_data/n%.csv
	@echo "Making $@"
	@python3 ./make-vocab-decks.py $< $@
	@echo "Done"