TARGET = c_kutsuu_asm
SRC_ASM = main.s
SRC_C = kerro.c print.c

OBJ_ASM = $(SRC_ASM:.s=.o)
OBJ_C = $(SRC_C:.c=.o)

AS = as
CC = gcc
LD = gcc

.PHONY: all clean run

all: $(TARGET)

%.o: %.s
	$(AS) -o $@ $<

%.o: %.c
	$(CC) -c -o $@ $<

$(TARGET): $(OBJ_ASM) $(OBJ_C)
	$(LD) -o $@ $^

run: all
	@./$(TARGET)

clean:
	rm -f $(TARGET) *.o
