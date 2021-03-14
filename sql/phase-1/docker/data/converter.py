#!/usr/bin/env python3

import re
import sys


def get_file_name() -> str:
    return "movies.dat"


def parse_line(line: str, print_comma: bool = True) -> str:
    split = line.replace("\n", "").replace(r"\N", "null")
    split = split.replace("'", "''").split("\t")
    line_terminator = "," if print_comma else ";"
    ret = "("
    for field in split[:-1]:
        ret += f"{surround_with_quotes_if_string(field)}, "
    ret += f"{surround_with_quotes_if_string(split[-1])}){line_terminator}"
    return ret


def surround_with_quotes_if_string(field: str) -> str:
    number_pattern = r'^[\d\.]+$'
    is_word = len(re.findall(number_pattern, field)) == 0
    if is_word and not is_null(field):
        return f"'{field}'"
    else:
        return field


def is_null(field: str) -> str:
    return field == "null"


def read_movies(header: str, filename: str) -> str:
    ret = f"{header}\n"
    with open(filename, "r") as fh:
        lines = fh.readlines()
        for line in lines[:-1]:
            ret += f"    {parse_line(line)}\n"
        ret += f"    {parse_line(lines[-1], False)}\n"
        return ret


def main(*args, **kwargs) -> None:
    print(read_movies(*args, **kwargs), end='')


if __name__ == "__main__":
    args = {
        'header': 'INSERT INTO movies VALUES',
        'filename': get_file_name()
    }
    if len(sys.argv) > 1:
        args['filename'] = sys.argv[1]
    if len(sys.argv) > 2:
        args['header'] = sys.argv[2]
    main(**args)
