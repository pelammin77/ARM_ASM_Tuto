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
    mov r4, #0          @ r4 = laskuri (i = 0)
    mov r1, #5          @ r1 = vertailuarvo 5

loop:
    cmp r4, r1          @ vertaillaan: i < 5?
    bge done            @ jos i >= 5 → ulos

    @ Tulosta "i = "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #4
    mov r7, #4
    svc 0

    @ ASCII-muunnos laskurin arvosta
    ldr r1, =buffer
    mov r3, r4          @ kopioidaan laskuri
    add r2, r3, #'0'    @ ASCII: 0–9
    strb r2, [r1]

    @ Tulosta numero
    mov r0, #1
    ldr r1, =buffer
    mov r2, #1
    mov r7, #4
    svc 0

    @ Tulosta rivinvaihto
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc 0

    @ i++
    add r4, r4, #1
    b loop

done:
    mov r0, r4          @ palautetaan laskurin lopullinen arvo (5)
    mov r7, #1
    svc 0
