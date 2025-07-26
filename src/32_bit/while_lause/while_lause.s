/*
 ============================================================================
  ARM32 Assembly: while-silmukan toteutus + tulostus
  ------------------------------------------
  Vastaa C-koodia:
      int i = 0;
      while (i < 5) {
          printf("i = %d\n", i);
          i++;
      }
      return i;

  Perusideat:
    - Käytetään rekisteriä r0 laskurina
    - Rekisterissä r1 on vertailuarvo (5)
    - Silmukka käyttää labelia: loop:
    - Käytetään 'cmp' + 'bge' vertailua (jump jos r0 >= 5)
    - Tulostus tehdään syscall 4 (write)
    - ASCII-muunnos toimii vain arvoille 0–9

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
    mov r1, #5          @ r1 = 5 (raja-arvo)

loop:
    cmp r0, r1          @ vertaillaan: onko r0 < 5?
    bge done            @ jos r0 >= 5 → hyppää ulos silmukasta

    @ Tulostetaan merkkijono "i = "
    mov r2, #1          @ tiedostodeskriptoriksi stdout (1)
    ldr r3, =prefix     @ osoitin alkuun: "i = "
    mov r4, #4          @ pituus 4 merkkiä
    mov r7, #4          @ syscall 4 = write
    mov r0, r2          @ r0 = 1 (stdout)
    mov r1, r3          @ r1 = osoitin tekstiin
    mov r2, r4          @ r2 = merkkien määrä
    svc 0

    @ Muunna r0 (laskurin arvo) ASCII-merkiksi ja kirjoita bufferiin
    ldr r1, =buffer
    add r2, r0, #'0'    @ ASCII-koodi numerolle (vain 0–9)
    strb r2, [r1]       @ kirjoita merkki bufferiin

    @ Tulostetaan bufferin sisältö (1 merkki)
    mov r0, #1
    ldr r1, =buffer
    mov r2, #1
    mov r7, #4
    svc 0

    @ Tulostetaan rivinvaihto
    mov r0, #1
    ldr r1, =newline
    mov r2, #1
    mov r7, #4
    svc 0

    @ Kasvata laskuria (i++)
    add r0, r0, #1
    b loop              @ hyppää takaisin silmukan alkuun

done:
    mov r7, #1          @ syscall 1 = exit
    svc 0               @ poistu ohjelmasta, r0 on tulos
