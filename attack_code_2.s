movq $0x3539623939376661, %r12
movq %r12, 0x40(%rsp)
xorq %r12, %r12
movq %r12, 0x48(%rsp)
leaq 0x40(%rsp), %rdi
movq $0x4018fa, (%rsp)
ret
