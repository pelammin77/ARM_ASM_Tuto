/*
 ============================================================================
  ARM32 Assembly: for-silmukan toteutus + tulostus
  ------------------------------------------
  Vastaa C-koodia:
      for (int i = 0; i < 5; i++) {
          printf("i = %d\n", i);
      }
      return i;

  Keskeiset kohdat:
    - r4 = laskuri (i)
    - r5 = vertailuarvo (5)
    - ASCII-muunnos vain 0–9
    - Tulostus syscallilla (syscall 4)
    - exit-koodi palautetaan i:n lopullisena arvona
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
    mov r4, #0          @ i = 0
    mov r5, #5          @ for-silmukan vertailuarvo: i < 5

for_loop:
    cmp r4, r5          @ i < 5 ?
    bge done            @ jos i >= 5 → lopeta

    @ Tulosta "i = "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #4
    mov r7, #4
    svc 0

    @ ASCII-muunnos (r4 → r6 → ASCII)
    mov r6, r4
    ldr r1, =buffer
    add r2, r6, #'0'    @ ASCII: 0 = 48 → '0'
    strb r2, [r1]

    @ Tulosta numeromerkki
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

    @ i++
    add r4, r4, #1
    b for_loop

done:
    mov r0, r4          @ palautetaan lopullinen arvo (5)
    mov r7, #1
    svc 0
