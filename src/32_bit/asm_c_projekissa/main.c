#include <stdio.h>

// Ilmoitus assembly-funktiosta (ilman toteutusta)
extern int summa(int a, int b);

int main(void) {
    int x = 3;
    int y = 4;
    int tulos = summa(x, y);
    printf("Summa: %d\n", tulos);
    return 0;
}
