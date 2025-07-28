/*
 ============================================================================
  ARM32 Assembly: Taulukot ja osoittimet 
  ------------------------------------------
  Tehtävä:
      - Summaa taulukon arvot {1,2,3,4,5}
      - Käytä osoitteita (ldr [rx, #offset])
      - Tulosta summa
      - Palauta se exit-koodina

  Vastaava C-koodi:
      int data[] = {1,2,3,4,5};
      int sum = 0;
      for (int i = 0; i < 5; i++) {
          sum += data[i];
      }
      return sum;
 ============================================================================
*/

.global _start

.section .data
data:       .word 1, 2, 3, 4, 5    @ 5 x 32-bittistä sanaa (20 tavua)
prefix:     .ascii "Summa: "
newline:    .ascii "\n"

.section .bss
buffer:     .skip 2               @ ASCII-numero (vain 0–99)

.section .text
_start:
    mov r4, #0          @ sum = 0
    mov r5, #0          @ indeksi i = 0
    mov r6, #5          @ r6 = taulukon pituus
    ldr r7, =data       @ r7 = osoitin taulukon alkuun

loop:
    cmp r5, r6          @ if (i >= 5)
    bge print_result    @     → valmis, siirry tulostukseen

    ldr r0, [r7, r5, LSL #2]  @ r0 = data[i], koska word = 4 tavua → LSL #2
    add r4, r4, r0      @ sum += data[i]

    add r5, r5, #1      @ i++
    b loop

print_result:
    @ Tulosta "Summa: "
    mov r0, #1
    ldr r1, =prefix
    mov r2, #7
    mov r7, #4
    svc 0

    @ ASCII-muunnos: r4 (sum) → buffer (vain 0–99 tuettu)
    mov r0, r4
    ldr r1, =buffer

    mov r2, #10
    udiv r3, r0, r2         @ kymmenet = r0 / 10
    mul r6, r3, r2          @ r6 = 10 * kymmenet
    sub r0, r0, r6          @ ykköset = r0 - 10*kymmenet

    add r3, r3, #'0'        @ kymmenet ASCII
    strb r3, [r1]

    add r0, r0, #'0'        @ ykköset ASCII
    strb r0, [r1, #1]

    @ Tulosta ASCII-numero
    mov r0, #1
    ldr r1, =buffer
    mov r2, #2
    mov r7, #4
    svc 0

    @ Tulosta rivinvaihto
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc 0

    @ Palauta summa exit-koodina (vain 0–255 näkyy)
    mov r0, r4
    mov r7, #1
    svc 0
