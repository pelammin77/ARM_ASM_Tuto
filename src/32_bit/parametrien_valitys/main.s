.global _start
.extern summa       @ funktio tulee toisesta moduulista

.section .data
prefix:     .ascii "Tulos: "
newline:    .ascii "\n"

.section .bss
buffer:     .skip 1

.section .text
_start:
    mov r0, #5          @ ensimmäinen argumentti (a)
    mov r1, #2          @ toinen argumentti (b)
    bl summa            @ kutsutaan summa(a, b)
    mov r3, r0          @ säilytetään tulos r3:ssa

    @ Tulosta "Tulos: "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #7
    mov r7, #4
    svc 0

    @ ASCII-tulostus
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

    @ Palauta tulos exit-koodina
    mov r0, r3
    mov r7, #1
    svc 0
