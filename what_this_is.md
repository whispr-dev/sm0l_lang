v.0.1 GOAL RECAP:
Build a Turing complete programming language. - remains tehcnically tested but not truly pushed

Implement it using assembly or raw machine code. - pure 16bit Self-modifying OISC emulator assembly with 256 bytes of RAM

Make it as small as humanly/inhumanly possible — character count, byte count, every bit squeezed for essence. - 80 lines / 1449 chars


v.0.2 You now have:
A working Subleq VM 💾 

Memory-mapped I/O ✅

A real halt plan 🛑

A functional Subleq assembler ⚙️

Confidence to face DOSBox’s wrath again ⚔️


v.0.3 When you’re ready:
We can build a visual debugger 🧠

Add label support to the assembler 🏷️

Write real subleq “apps” like a counter, echo, or Mandelbrot 🍩

Or wrap it into a tiny .iso bootable floppy (yes, we can go there)


v.1.0 subleq_debugger.asm — The Fully Integrated Subleq VM + Step Debugger
Assembly-only

DOSBox-compatible .COM

256-word RAM

Memory-mapped I/O

HALT support (B == -3)

Step-by-step instruction debugger

BIOS output + pause via int 16h


