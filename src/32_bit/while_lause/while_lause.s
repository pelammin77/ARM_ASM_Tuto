/*
 ============================================================================
  ARM32 Assembly: while-silmukan toteutus + tulostus (korjattu)
  ------------------------------------------
  Vastaa C-koodia:
      int i = 0;
      while (i < 5) {
          printf("i = %d\n", i);
          i++;
      }
      return i;

  Keskeiset kohdat:
    - r0 toimii laskurina (i)
    - r1 on raja-arvo 5
    - Tulostus: syscall 4 (write)
    - ASCII-muunnos toimii vain 0–9
    - r0 kopioidaan ennen ASCII-muunnosta → vältetään bugi
 ============================================================================
*/

.global _start

.section .data
prefix:     .ascii "i = "
newline:    .ascii "\n"

.section .bss
.balign 4
buffer:     .skip 1      @ 1 merkki tulostettavalle numerolle

.section .text
_start:
    mov r0, #0          @ r0 = 0 (laskurin alustus)
    mov r1, #5          @ r1 = 5 (vertailuarvo)

loop:
    cmp r0, r1          @ vertaillaan: r0 < 5?
    bge done            @ jos r0 >= 5 → pois silmukasta

    @ Tulostetaan "i = "
    mov r2, #1          @ stdout = 1
    ldr r3, =prefix     @ osoitin "i = "
    mov r4, #4          @ merkkien määrä
    mov r7, #4          @ syscall 4 = write
    mov r0, r2          @ fd = stdout
    mov r1, r3          @ osoitin dataan
    mov r2, r4          @ pituus
    svc 0

    @ ASCII-muunnos ja tulostus numerosta
    ldr r1, =buffer     @ osoitin bufferiin
    mov r3, r0          @ kopioidaan r0 → r3, jotta r0 ei mene rikki
    add r2, r3, #'0'    @ ASCII-muunnos: 0 → '0', 1 → '1', jne.
    strb r2, [r1]       @ kirjoita yksi merkki bufferiin

    mov r0, #1          @ stdout
    ldr r1, =buffer
    mov r2, #1          @ pituus 1
    mov r7, #4          @ syscall 4
    svc 0

    @ Tulostetaan rivinvaihto
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc 0

    @ i++
    add r0, r0, #1
    b loop

done:
    mov r7, #1          @ syscall 1 = exit
    svc 0               @ palauttaa r0 arvon (tässä 5)
