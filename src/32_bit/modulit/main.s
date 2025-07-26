.global _start
.extern summa     @ ilmoitetaan, että funktio löytyy toisesta tiedostosta

.section .data
prefix:     .ascii "Tulos: "
newline:    .ascii "\n"

.section .bss
buffer:     .skip 1

.section .text
_start:
    bl summa            @ kutsutaan aliohjelmaa
    mov r3, r0          @ tallennetaan tulos myöhempää käyttöä varten

    @ Tulostus "Tulos: "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #7
    mov r7, #4
    svc 0

    @ ASCII-tulostus tuloksesta
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

    @ Palautetaan tulos exit-koodina
    mov r0, r3
    mov r7, #1
    svc 0
