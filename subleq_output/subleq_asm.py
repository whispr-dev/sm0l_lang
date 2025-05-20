#!/usr/bin/env python3

import sys

def assemble(lines):
    mem = []
    for line in lines:
        line = line.split(';')[0].strip()  # Strip comments
        if not line:
            continue
        if line.lower().startswith("subleq"):
            parts = line[6:].strip().split(",")
            if len(parts) != 3:
                raise ValueError(f"Invalid subleq: {line}")
            a = int(parts[0].strip())
            b = int(parts[1].strip())
            c = int(parts[2].strip())
            mem.extend([a, b, c])
        else:
            raise ValueError(f"Unrecognized line: {line}")
    
    # Pad to 256 words
    while len(mem) < 256:
        mem.append(0)
    return mem[:256]

def write_asm(mem, output_file):
    with open(output_file, "w") as f:
        f.write("memory:\n")
        for i, word in enumerate(mem):
            f.write(f"    dw {word}\n")

def write_bin(mem, output_file):
    with open(output_file, "wb") as f:
        for word in mem:
            f.write(word.to_bytes(2, byteorder='little', signed=True))

def main():
    if len(sys.argv) < 3:
        print("Usage: subleq_asm.py input.sub output.asm|output.bin")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]

    with open(input_file) as f:
        lines = f.readlines()

    mem = assemble(lines)

    if output_file.endswith(".asm"):
        write_asm(mem, output_file)
    elif output_file.endswith(".bin"):
        write_bin(mem, output_file)
    else:
        print("Unsupported output format. Use .asm or .bin")
        sys.exit(1)

if __name__ == "__main__":
    main()
