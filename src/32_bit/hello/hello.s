@ stdin = 0
@ stout = 1
@ stderr = 2

.global _start

.section .data
msg:
    .ascii "Hello, World!\n"
len = . - msg

.section .text
_start:
    mov r0, #1          @ tiedostodeskriptori: stdout (1)
    ldr r1, =msg        @ osoitin tulostettavaan merkkijonoon
    mov r2, #len        @ merkkijonon pituus
    mov r7, #4          @ syscall 4 = sys_write
    svc 0

    mov r0, #0          @ exit-koodi 0
    mov r7, #1          @ syscall 1 = sys_exit
    svc 0
