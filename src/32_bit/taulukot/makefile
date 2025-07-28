# Tiedostonimi ilman päätettä
TARGET = summaa_taulukko
SRC = $(TARGET).s
OBJ = $(TARGET).o

AS = as
LD = ld

.PHONY: all clean run

# Oletustavoite: käännös ja linkitys
all: $(TARGET)

# Käännä Assembly-tiedosto objektiksi
$(OBJ): $(SRC)
	$(AS) -o $@ $<

# Linkitä objektista suoritettava tiedosto
$(TARGET): $(OBJ)
	$(LD) -o $@ $<

# Suorita ohjelma ja näytä exit-koodi
run: all
	@./$(TARGET); RET=$$?; echo "Exit-koodi (palautettu arvo): $$RET"

# Siivoa käännöstiedostot
clean:
	rm -f $(TARGET) $(OBJ)
