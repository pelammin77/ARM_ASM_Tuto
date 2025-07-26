.global _start

_start:
    mov r0, #7      @ exit-koodi (palautetaan shellille)
    mov r7, #1      @ syscall 1 = exit
    svc 0           @ suorita system call
