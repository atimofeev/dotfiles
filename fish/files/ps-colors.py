#!/usr/bin/env python3
"""Script to color 'ps -ef --forest' output"""

import sys
import re

# ANSI escape color codes
HEADER_COLOR = "\033[91m" # red
USERID_COLOR = "\033[92m" # green
SYSTEM_PROC_COLOR = "\033[93m" # yellow
TREE_ASCII_COLOR = "\033[94m" # blue
COMMAND_COLOR = "\033[95m" # magenta
ARGUMENT_COLOR = "\033[96m" # cyan
RESET_COLOR = "\033[0m" # reset

ps_output = []

def ljustcolor(text: str, padding: int, char=" ") -> str:
    """Elegant solution to ljust issues with ANSI coloring
    https://stackoverflow.com/a/75526408"""
    pattern = r'(?:\x1B[@-_]|[\x80-\x9F])[0-?]*[ -/]*[@-~]'
    matches = re.findall(pattern, text)
    offset = sum(len(match) for match in matches)
    return text.ljust(padding + offset, char[0])

def read_stdin():
    """Read cells from stdin and write them to ps_output 2d array"""
    for row in sys.stdin:
        columns = re.split(r'\s+', row.strip())
        uid_to_time = columns[:7]
        cmd = " ".join(columns[7:])
        ps_output.append(uid_to_time + [cmd])

def iterate_rows():
    column_widths = [max(len(str(row[i])) for row in ps_output) \
        for i in range(len(ps_output[0]))]
    for row in ps_output:
        if "UID" in row and "PID" in row:
            print_header(row, column_widths)
            continue
        print_row(row, column_widths)

def print_header(row, col_widths):
    for idx, col in enumerate(row):
        if idx < 7:
            print(ljustcolor(HEADER_COLOR + col.strip() + RESET_COLOR, col_widths[idx]), end=" ")
        else: # ignore width of CMD column
            print(HEADER_COLOR + col.strip() + RESET_COLOR, end=" ")
    print()

def print_row(row, col_widths):
    output_row = []
    for idx, col in enumerate(row):
        if idx == 0:
            output_row.append(ljustcolor(USERID_COLOR + col + RESET_COLOR, col_widths[idx]))
        elif idx < 7:
            output_row.append(str(col).ljust(col_widths[idx]))
        else: # ignore width of CMD column
            output_row.append(process_cmd(col))
    print(" ".join(output_row))

def process_cmd(col):
    """Process CMD section of 'ps' output.
    Colorize: ASCII tree, sys procs, regular apps,
    regular app arguments."""
    remaining_part = col
    ascii_tree_match = re.match(r'^([|\\_ ]+)', col)
    if ascii_tree_match:
        ascii_tree = ascii_tree_match.group(1)
        remaining_part = remaining_part[len(ascii_tree):]
        col = col.replace(ascii_tree, TREE_ASCII_COLOR + ascii_tree + RESET_COLOR, 1)
    system_proc_match = re.search(r'(\[[\w/:.+-.]+\])', remaining_part)
    if system_proc_match:
        system_proc = system_proc_match.group(1)
        col = col.replace(system_proc, SYSTEM_PROC_COLOR + system_proc + RESET_COLOR, 1)
    else:
        cmd_parts = remaining_part.split(' ', 1)
        col = col.replace(cmd_parts[0], COMMAND_COLOR + cmd_parts[0] + RESET_COLOR, 1)
        if len(cmd_parts) > 1:
            col = col.replace(cmd_parts[1], ARGUMENT_COLOR + cmd_parts[1] + RESET_COLOR, 1)
    return col

def main():
    read_stdin()
    iterate_rows()

main()
