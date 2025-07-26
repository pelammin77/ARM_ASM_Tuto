.global summa

.text
summa:
    push {lr}           @ tallenna paluuosoite
    mov r0, #3
    mov r1, #4
    add r0, r0, r1      @ r0 = 3 + 4
    pop {lr}
    bx lr               @ paluu kutsujalle
