.global main
.extern kerro
.extern print_result

.text
main:
    mov r0, #6          @ r0 = x
    mov r1, #7          @ r1 = y
    bl kerro            @ kutsu C-funktiota: r0 = kerro(r0, r1)
                        @ tulos tulee takaisin r0:aan

    @ Tulosta tulos C-puolella
    bl print_result     @ oma C-funktio joka käyttää printf:tä

    mov r7, #1          @ exit
    svc 0

.section .note.GNU-stack,"",%progbits
