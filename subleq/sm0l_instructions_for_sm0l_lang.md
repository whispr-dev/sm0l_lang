working in Language: subleq
One instruction:

text
Copy
Edit
subleq A, B, C
mem[B] = mem[B] - mem[A]
if mem[B] ≤ 0 then PC = C else PC = PC + 3

-------


ocmpile with:

nasm -f bin subleq.asm -o subleq.com




HOW WE IMPLEMENT HALT IN SUBLEQ
We reserve a magic memory address for special commands.

By convention, we say:

nginx
Copy
Edit
subleq X, -3, Y
→ if B == -3, the machine should HALT.


TL;DR
Syntax	            Meaning
subleq X, -3, Y	    HALT immediately
subleq 0, -3, 0	    Safe HALT
