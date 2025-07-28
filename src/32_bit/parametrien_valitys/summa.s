.global summa

.text
summa:
    push {lr}           @ tallenna paluuosoite
    add r0, r0, r1      @ r0 = r0 + r1
    pop {lr}
    bx lr               @ palaa kutsujalle
