import csv
import sys
import re


def get_data_from_csv(filename: str):
    data = list()
    with open(filename, 'r') as csvfile:
        csvreader = csv.DictReader(csvfile)
        data = [line for line in csvreader]

    return list(data)


def write_audio_to_requirements(csv_in: str, requirements: str):
	data = get_data_from_csv(csv_in)
	filterer = re.compile("^\\[sound:(.*)\\]$")

	with open(requirements, 'w') as requirements_file:
		for i in range(0, len(data), 2):
			requirements_file.write(filterer.fullmatch(data[i]["audio"]).group(1) + "\n")


def main():
    args = sys.argv
    # args = ["", "Sources/yomitan-jlpt-vocab/original_data/n5.csv", "N5/vocab-deck.csv"]
    # print(args)
    if len(args) != 3:
        return 1
    if len(args) == 3:
        write_audio_to_requirements(args[1], args[2])
        return 0

if __name__ == '__main__':
    main()