.global _start

.text
_start:
    mov r0, #3        @ r0 = 3
    mov r1, #4        @ r1 = 4
    add r0, r0, r1    @ r0 = r0 + r1 = 7 (tulos exit-koodiksi)

    mov r7, #1        @ syscall 1 = exit
    svc 0
