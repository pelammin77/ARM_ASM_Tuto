# Tiedostonimi ilman päätettä
TARGET = funktio_summa
SRC = $(TARGET).s
OBJ = $(TARGET).o

AS = as
LD = ld

.PHONY: all clean run

# Käännös ja linkitys
all: $(TARGET)

$(OBJ): $(SRC)
	$(AS) -o $@ $<

$(TARGET): $(OBJ)
	$(LD) -o $@ $<

# Suoritus ja tuloksen näyttö
run: all
	@./$(TARGET); RET=$$?; echo "Exit-koodi (palautettu arvo): $$RET"

# Poisto
clean:
	rm -f $(TARGET) $(OBJ)
