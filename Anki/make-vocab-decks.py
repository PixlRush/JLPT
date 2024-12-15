import csv
import sys


def get_data_from_csv(filename: str) -> list[dict[str, str]]:
    data = list()
    with open(filename, 'r') as csvfile:
        csvreader = csv.DictReader(csvfile)
        data = [line for line in csvreader]

    return(list(data))


def write_data_to_csv(data: list[dict[str, str]], filename: str, fields: [str, ...] =["front", "back"]):
    with open(filename, 'w') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fields)
        writer.writeheader()
        for datum in data:
            writer.writerow(datum)


def reformat_data_for_anki(data: list[dict[str, str]]) -> list[dict[str,str]]:
    redata = list()
    for datum in data:
        if not datum["kanji"] and datum["kana"]:
            redata.append(
                {"ftitle": datum["kana"],
                "fsubtitle": "",
                "btitle": datum["waller_definition"],
                "bsubtitle": "",
                "audio": f"[sound:{datum["kana"]}.wav]"}
            )
            redata.append(
                {"ftitle": datum["waller_definition"],
                "fsubtitle": "",
                "btitle": datum["kana"],
                "bsubtitle": "",
                "audio": f"[sound:{datum["kana"]}.wav]"}
            )
        else:
            redata.append(
                {"ftitle": datum["kanji"],
                "fsubtitle": f"({datum["kana"]})",
                "btitle": datum["waller_definition"],
                "bsubtitle": "",
                "audio": f"[sound:{datum["kanji"]}.wav]"}
            )
            redata.append(
                {"ftitle": datum["waller_definition"],
                "fsubtitle": "",
                "btitle": datum["kanji"],
                "bsubtitle": f"({datum["kana"]})",
                "audio": f"[sound:{datum["kanji"]}.wav]"}
            )

    return redata


def make_deck_from_csv(input_filename: str, csv_output: str, requirements_output: str = None) -> None:
    reformatted_data = reformat_data_for_anki(get_data_from_csv(input_filename))
    if requirements_output is not None:
        write_data_to_requirements(reformatted_data, requirements_output)
    write_data_to_csv(reformatted_data, csv_output, fields=reformatted_data[0].keys())


def main():
    args = sys.argv
    # args = ["", "Sources/yomitan-jlpt-vocab/original_data/n5.csv", "N5/vocab-deck.csv"]
    # print(args)
    if len(args) != 3:
        return 1
    if len(args) == 3:
        make_deck_from_csv(args[1], args[2])
        return 0

if __name__ == '__main__':
    main()