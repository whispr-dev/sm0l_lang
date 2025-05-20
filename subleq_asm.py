#!/usr/bin/env python3

import sys

def parse(lines):
    mem = []
    labels = {}
    fixups = []

    address = 0

    for line in lines:
        line = line.split(';')[0].strip()
        line = line.replace(",", " ")
        tokens = line.split()

        if not line:
            continue

        # label:
        if ':' in line:
            label, rest = line.split(':', 1)
            label = label.strip()
            labels[label] = address
            line = rest.strip()
            if not line:
                continue

        tokens = line.split()

        if tokens[0].lower() == "subleq":
            if len(tokens) != 4:
                raise ValueError(f"Invalid subleq: {line}")
            a, b, c = tokens[1], tokens[2], tokens[3]
            mem.extend([a, b, c])
            address += 3
        elif tokens[0].lower() == "dw":
            mem.append(tokens[1])
            address += 1
        else:
            raise ValueError(f"Unknown directive: {tokens[0]}")

    return mem, labels, fixups

def resolve_symbols(mem, labels):
    resolved = []
    for value in mem:
        if isinstance(value, str):
            value = value.strip()
            if value.startswith("'") and value.endswith("'") and len(value) == 3:
                # It's a character like 'H'
                resolved.append(ord(value[1]))
            else:
                try:
                    resolved.append(int(value))
                except ValueError:
                    if value not in labels:
                        raise ValueError(f"Unknown symbol: {value}")
                    resolved.append(labels[value])
        else:
            resolved.append(value)
    return resolved

def write_asm(mem, out_path):
    with open(out_path, "w") as f:
        f.write("memory:\n")
        for word in mem:
            f.write(f"    dw {word}\n")

def write_bin(mem, out_path):
    with open(out_path, "wb") as f:
        for word in mem:
            f.write(int(word).to_bytes(2, byteorder="little", signed=True))

def main():
    if len(sys.argv) != 3:
        print("Usage: subleq_asm.py input.sub output.asm|output.bin")
        sys.exit(1)

    infile, outfile = sys.argv[1], sys.argv[2]
    with open(infile) as f:
        lines = f.readlines()

    mem, labels, _ = parse(lines)
    mem = resolve_symbols(mem, labels)

    # pad to 256 words
    while len(mem) < 256:
        mem.append(0)

    if outfile.endswith(".asm"):
        write_asm(mem, outfile)
    elif outfile.endswith(".bin"):
        write_bin(mem, outfile)
    else:
        print("Unknown output format (use .asm or .bin)")
        sys.exit(1)

if __name__ == "__main__":
    main()
