TARGET = laskenta
SRC = $(TARGET).s
OBJ = $(TARGET).o

AS = as
LD = ld

.PHONY: all clean run

all: $(TARGET)

$(OBJ): $(SRC)
	$(AS) -o $@ $<

$(TARGET): $(OBJ)
	$(LD) -o $@ $<

run: all
	@./$(TARGET); RET=$$?; echo "Exit-koodi (tulos): $$RET"


clean:
	rm -f $(TARGET) $(OBJ)
