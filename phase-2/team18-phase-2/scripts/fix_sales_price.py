#!/usr/bin/env python3

import re
import sys
from typing import List


SEARCH = r'(\d+,\d+,\d+,\d+,\d+,[\w\-\ \;\.]+,\d+)\,'
REPLACEMENT = r'\1.'


def fix_sales_price(line: str) -> str:
    return re.sub(SEARCH, REPLACEMENT, line)


def fix_sales_file(filename: str) -> None:
    with open(filename, "r") as fh:
        for line in fh.readlines():
            print(fix_sales_price(line), end='')


def main(args: List[str]) -> None:
    if len(args) < 2:
        print("No file specified. Please enter the filename as the first arguments.")
    else:
        fix_sales_file(args[1])


if __name__ == "__main__":
    main(sys.argv)
