.global summa

.text
summa:
    push {lr}           @ tallenna paluuosoite
    add r0, r0, r1      @ r0 = r0 + r1 (palautetaan tulos r0:ssa)
    pop {lr}            @ palauta LR
    bx lr               @ palaa kutsujalle
