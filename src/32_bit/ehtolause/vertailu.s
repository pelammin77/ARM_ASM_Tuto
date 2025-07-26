/*
 ============================================================================
  ARM32 Assembly: Vertailut ja haarautumiset (Jakso 4)
  ------------------------------------------
  Käytössä käskyt:
    - cmp rA, rB       → vertailee rA - rB (ei tallenna tulosta, mutta asettaa liput)
    - bgt label        → hyppää labeliin, jos rA > rB
    - beq label        → hyppää labeliin, jos rA == rB
    - blt label        → hyppää labeliin, jos rA < rB
    - b label          → ehdoton hyppy (kuten goto)
    - exit:            → ohjelman päätepiste (label, johon hypätään ennen poistumista)

  Haarautuminen vastaa C-kielen ehtolauseita:
    cmp r0, r1
    bgt suurempi      // if (r0 > r1) goto suurempi;
    beq yhtasuuri     // else if (r0 == r1) goto yhtasuuri;
    blt pienempi      // else if (r0 < r1) goto pienempi;

  Huom: viimeisessä tapauksessa (pienempi), ei tarvita 'b exit', koska 'exit' seuraa heti.

  Yleisimmät ehdolliset haarakäskyt (signed):
    beq  = equal              (Z = 1)
    bne  = not equal          (Z = 0)
    bgt  = greater than       (Z = 0 and N = V)
    blt  = less than          (N != V)
    bge  = greater or equal   (N = V)
    ble  = less or equal      (Z = 1 or N != V)

 ============================================================================
*/

.global _start

.text
_start:
    mov r0, #5         @ ensimmäinen luku
    mov r1, #3         @ toinen luku

    cmp r0, r1         @ vertaillaan r0 - r1

    bgt suurempi       @ jos r0 > r1 → hyppy suurempi:
    beq yhtasuuri      @ jos r0 == r1 → hyppy yhtasuuri:
    blt pienempi       @ jos r0 < r1 → hyppy pienempi:

suurempi:
    mov r0, #1         @ koodi: suurempi
    b exit             @ hyppy pois luonnollisesta koodivirrasta

yhtasuuri:
    mov r0, #2         @ koodi: yhtäsuuri
    b exit             @ hyppy pois luonnollisesta koodivirrasta

pienempi:
    mov r0, #3         @ koodi: pienempi
    @ ei tarvitse b exit, koska seuraava rivi on exit

exit:
    mov r7, #1         @ syscall 1 = exit
    svc 0
