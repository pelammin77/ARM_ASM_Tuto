/*
 ============================================================================
  ARM32 Assembly: Tiedostoon kirjoittaminen
  ------------------------------------------
  Tämä ohjelma:
    1. Avaa (tai luo) tiedoston nimeltä "testi.txt"
    2. Kirjoittaa sinne tekstin "Terve Assembly!\n"
    3. Sulkee tiedoston

  Vastaa suurin piirtein seuraavaa C-koodia:

      int fd = open("testi.txt", O_CREAT | O_WRONLY, 0644);
      write(fd, "Terve Assembly!\n", 16);
      close(fd);

  Tärkeimmät rekisterit:
    - r0 = 1. argumentti (esim. tiedoston nimi tai fd)
    - r1 = 2. argumentti
    - r2 = 3. argumentti
    - r7 = syscall-numero

 ============================================================================
*/

.global _start

.section .data
filename:   .asciz "testi.txt"           @ Tiedoston nimi
tekstidata: .asciz "Terve Assembly!\n"   @ Teksti, joka kirjoitetaan tiedostoon

.section .text
_start:

    @--------------------------
    @ 1. Avaa tiedosto kirjoitusta varten
    @    O_WRONLY | O_CREAT = 0x41
    @    oikeudet: 0644 (rw-r--r--)
    @--------------------------
    ldr r0, =filename     @ tiedoston nimi
    mov r1, #0x41         @ lippu: O_WRONLY | O_CREAT
    mov r2, #0o644        @ oikeudet: rw-r--r-- (oktaalina)
    mov r7, #5            @ syscall: sys_open
    svc 0
    mov r4, r0            @ tallenna file descriptor (fd) r4:ään

    @--------------------------
    @ 2. Kirjoita teksti tiedostoon
    @--------------------------
    mov r0, r4            @ fd
    ldr r1, =tekstidata   @ osoitin tekstiin
    mov r2, #16           @ pituus (merkkien määrä, mukaan lukien \n)
    mov r7, #4            @ syscall: sys_write
    svc 0

    @--------------------------
    @ 3. Sulje tiedosto
    @--------------------------
    mov r0, r4            @ fd
    mov r7, #6            @ syscall: sys_close
    svc 0

    @--------------------------
    @ 4. Poistu ohjelmasta
    @--------------------------
    mov r0, #0            @ exit-koodi
    mov r7, #1            @ syscall: sys_exit
    svc 0
