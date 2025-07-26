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
    mov r5, #5          @ r5 = vertailuarvo 5

loop:
    cmp r4, r5          @ i < 5 ?
    bge done            @ jos i >= 5 → lopeta

    @ Tulosta "i = "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #4
    mov r7, #4
    svc 0

    @ ASCII-muunnos (kopioi r4 → r6, ettei r4 muutu!)
    mov r6, r4
    ldr r1, =buffer
    add r2, r6, #'0'
    strb r2, [r1]

    @ Tulosta yksi merkki bufferista
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

    @ Kasvata i++
    add r4, r4, #1
    b loop

done:
    mov r0, r4          @ palautetaan i:n lopullinen arvo (5)
    mov r7, #1
    svc 0
