/*
 ============================================================================
  ARM32 Assembly: Aliohjelmat ja pino 
  ------------------------------------------
  Esimerkki:
    - Pääohjelma kutsuu aliohjelmaa 'summa'
    - 'summa' laskee 3 + 4
    - Tulos palautetaan rekisterissä r0
    - Tulostetaan tulos
    - Käytössä: bl, bx lr, push, pop, sp (r13), lr (r14)
 ============================================================================
*/

.global _start

.section .data
prefix:     .ascii "Tulos: "
newline:    .ascii "\n"

.section .bss
buffer:     .skip 1      @ tilaa yhdelle ASCII-merkille

.section .text
_start:
    @ Kutsu funktiota summa
    bl summa            @ tallentaa paluuosoitteen lr-rekisteriin

    @ Tulostetaan "Tulos: "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #7
    mov r7, #4
    svc 0

    @ ASCII-muunnos ja tulostus
    mov r3, r0          @ kopioi tulos r3:een, säilytä r0:aa exitiin
    ldr r1, =buffer
    add r2, r3, #'0'
    strb r2, [r1]

    mov r0, #1
    ldr r1, =buffer
    mov r2, #1
    mov r7, #4
    svc 0

    @ Rivinvaihto
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc 0

    @ Poistu ohjelmasta, palauta r0 = tulos
    mov r7, #1
    svc 0

@ =====================================================
@ Aliohjelma: summa
@ Laskee 3 + 4 ja palauttaa tuloksen r0:ssa
@ =====================================================
summa:
    push {lr}           @ tallenna paluuosoite pinolle
    mov r0, #3
    mov r1, #4
    add r0, r0, r1      @ r0 = r0 + r1

    pop {lr}            @ palauta alkuperäinen lr
    bx lr               @ palaa kutsujalle
