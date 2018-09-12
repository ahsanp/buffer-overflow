# Buffer Overflow Attack Practice

This repository contains my execrise of understanding and performing buffer overflow attacks

This exercise is a part of the supplementary material to Computer Systems: A Programmer's Perspective

## Getting Started

We wish to perform buffer overflow attacks on ctarget and rtarget.

ctarget has been compiled without address space layout randomization (ASLR) so as to allow the stack addresses to remain
constant across executions. rtarget on the other hand is compiled with ASLR and the stack has also
been marked as unexecutable.

The following commands can be used to run the attacks on any of the two targets

```
./hex2raw < <attack_string> | ./<target>
```
OR
```
./hex2raw < <attack_string> > injection_code
./ctarget -q -i injection_code
```

## Approaches

We use simple code injection to perform attack on ctarget and return oriented programming (ROP) to attack
rtarget.

We perform the following attacks on ctarget:
* Instead of returning to test() return to touch1() (change return address)
* Instead of returning to test() return to touch2() pass the cookie to touch2() as an argument (store cookie in %rdi - attack_code.s)
* Instead of returning to test() return to touch3() with string representation of your cookie as an argument(store string on stack and address in %rdi - (attack_code_2.s))

We perform the following attack on rtarget:
* Instead of returnint to test() return to touch2() and pass the cookie as an argument (use ROP to perform the attack)

For ROP we can only use the gadgets provided in the farm.c file.

## Generate attack string from assembly attack code
The attack_code.s and attack_code_2.s files contain the assembly code that was used to perform attacks on ctarget. To see the actual attack string
generated using the assembly file we use `objdump` as follows
```
gcc -c attack_code.s -o attack_code.o
objdump -d attack_code.o > disassembled_code.s
```
We can then look at the hex values of each line to figure out the actual attack string