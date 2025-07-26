# Tiedostonimi ilman päätettä
TARGET = for_lause
SRC = $(TARGET).s
OBJ = $(TARGET).o

AS = as
LD = ld

.PHONY: all clean run

# Oletuskäännös
all: $(TARGET)

# Käännös: Assembly → objektitiedosto
$(OBJ): $(SRC)
	$(AS) -o $@ $<

# Linkitys: objektista suoritettava tiedosto
$(TARGET): $(OBJ)
	$(LD) -o $@ $<

# Suoritus + paluuarvon tulostus
run: all
	@./$(TARGET); RET=$$?; echo "Exit-koodi (palautettu arvo): $$RET"

# Siivous
clean:
	rm -f $(TARGET) $(OBJ)
