# Tiedostonimi ilman päätettä
TARGET = hello
SRC = $(TARGET).s
OBJ = $(TARGET).o

# GNU binutils työkalut
AS = as
LD = ld

# Oletustavoite
all: $(TARGET)

# Käännös: hello.s -> hello.o
$(OBJ): $(SRC)
	$(AS) -o $@ $<

# Linkitys: hello.o -> hello
$(TARGET): $(OBJ)
	$(LD) -o $@ $<

# Siivous
clean:
	rm -f $(TARGET) $(OBJ)
