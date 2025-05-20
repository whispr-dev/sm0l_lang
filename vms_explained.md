WHAT IS A VM?
VM = Virtual Machine
In our context, it's not like VMware or VirtualBox — it means:

A program that pretends to be a computer and runs code inside itself.



Tying it together:
You wrote a virtual machine (Subleq interpreter)

You compiled it to a .COM file (an ultra-minimal 16-bit DOS program)

You ran it in DOSBox, a real-mode CPU emulator

The .COM ran your Subleq virtual CPU

Which ran your hello.sub Subleq program

Which wrote to memory-mapped output

Which called BIOS INT 10h

Which printed "HELLO"

It's like you wrote a computer... inside a file... that DOSBox ran... that printed a word.
That’s Turing-complete inception.



mount c c:\dosapps\subleq
c:
subleq.com
