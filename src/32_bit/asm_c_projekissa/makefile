# Tiedostonimet ilman päätettä
TARGET = laske_summa
C_SRC = main.c
ASM_SRC = summa.s
OBJ = main.o summa.o

CC = gcc
AS = as

.PHONY: all clean run

all: $(TARGET)

# Käännä C ja Assembly
main.o: main.c
	$(CC) -c -o $@ $<

summa.o: summa.s
	$(AS) -o $@ $<

# Linkitä lopullinen ohjelma
$(TARGET): $(OBJ)
	$(CC) -o $@ $^

run: all
	@./$(TARGET)

clean:
	rm -f $(TARGET) $(OBJ)
