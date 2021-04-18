#!/usr/bin/env python3

import re
import sys
from typing import List


def fix_price(line: str) -> str:
    PRICE_REGEX = r'(\d+,[\w -;]+,\d+)\,(?=\d+\,\d+\,)'
    REPLACE_WITH = r'\1.'
    return re.sub(PRICE_REGEX, REPLACE_WITH, line)


def fix_file(file: str) -> None:
    with open(file, "r") as fh:
        for line in fh.readlines():
            print(fix_price(line), end="")


def main(args: List[str]) -> None:
    if len(args) < 2:
        print("No file specified. Enter filename as the first argument.")
    else:
        fix_file(args[1])


if __name__ == "__main__":
    main(sys.argv)
