#!/usr/bin/env python3


MOVIES_FILENAME = "movies.dat"


def parse_line(line: str, print_comma: bool = True) -> str:
    split = line.replace("\n", "").replace(r"\N", "null")
    split = split.replace("'", "''").split("\t")
    if print_comma:
        return f"({split[0]}, '{split[1]}', {split[2]}, {split[3]}, {split[4]}),"
    else:
        return f"({split[0]}, '{split[1]}', {split[2]}, {split[3]}, {split[4]});"


def read_movies() -> str:
    ret = "INSERT INTO movies VALUES\n"
    with open(MOVIES_FILENAME, "r") as fh:
        lines = fh.readlines()
        for line in lines[:-1]:
            ret += f"    {parse_line(line)}\n"
        ret += f"    {parse_line(lines[-1], False)}\n"
        return ret


def main():
    print(read_movies())


if __name__ == "__main__":
    main()
