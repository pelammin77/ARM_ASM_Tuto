.global main
.extern kerro
.extern print_result

.text
main:
    push {lr}           @ Tallenna paluuosoite

    mov r0, #6          @ r0 = x
    mov r1, #7          @ r1 = y
    bl kerro            @ kutsu C-funktiota: r0 = kerro(r0, r1)

    bl print_result     @ Tulosta tulos

    mov r0, #0          @ palautetaan exit-koodi 0 (main -> return 0)
    pop {lr}
    bx lr               @ palaa mainista

.section .note.GNU-stack,"",%progbits
