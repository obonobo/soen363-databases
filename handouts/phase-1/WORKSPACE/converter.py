#!/usr/bin/env python3


MOVIES_FILENAME = "movies.dat"


def parse_line(line: str) -> str:
    split = line.replace("\n", "").replace(r"\N", "null")
    split = split.replace("'", "''").split("\t")
    return f"({split[0]}, '{split[1]}', {split[2]}, {split[3]}, {split[4]}),"


def read_movies() -> str:
    ret = "INSERT INTO movies VALUES (\n"
    with open(MOVIES_FILENAME, "r") as fh:
        for line in fh.readlines():
            ret += f"    {parse_line(line)}\n"
    ret += ");"
    return ret.replace(",\n);", "\n);")


def main():
    print(read_movies())


if __name__ == "__main__":
    main()
