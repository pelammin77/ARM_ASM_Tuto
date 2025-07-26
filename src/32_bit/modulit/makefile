TARGET = ohjelma
OBJS = main.o summa.o

AS = as
LD = ld

.PHONY: all clean run

all: $(TARGET)

main.o: main.s
	$(AS) -o $@ $<

summa.o: summa.s
	$(AS) -o $@ $<

$(TARGET): $(OBJS)
	$(LD) -o $@ $(OBJS)

run: all
	@./$(TARGET); RET=$$?; echo "Exit-koodi (palautettu arvo): $$RET"

clean:
	rm -f $(TARGET) $(OBJS)
