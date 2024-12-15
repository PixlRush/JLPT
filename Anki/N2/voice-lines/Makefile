.PHONY: all voice-lines.txt purge

all: $(shell cat voice-lines.txt)

purge:
	@echo "Purging all .wav, .json, and .txt files"
	@mv voice-lines.txt voice-lines
	@rm -f *.wav *.json *.txt
	@mv voice-lines voice-lines.txt
	@echo "Done"

%.txt:
	@echo "[$*] Making"
	@echo $* > $@

%.json: %.txt
	@echo "[$*] Compiling"
	@curl -s \
		-X POST \
		"127.0.0.1:50021/audio_query?speaker=1"\
		--get --data-urlencode text@$< \
		> $@
	@rm $<

%.wav: %.json
	@echo "[$*] Synthesizing"
	@curl -s \
		-H "Content-Type: application/json" \
		-X POST -d @$< \
		"127.0.0.1:50021/synthesis?speaker=1" \
		> $@ \
		&& rm $< &&	echo "[$*] DONE        " \
		|| rm $@
