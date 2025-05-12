ASM     = nasm
LD      = ld
ASMFLAGS= -f elf64
SRC     = org.asm
OBJ     = $(SRC:.asm=.o)
OUT     = reverse

.PHONY: all clean shellcode

all: $(OUT)

$(OUT): $(OBJ)
	$(LD) -o $@ $^

%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

shellcode: $(OUT)
	@echo "[*] Extracting shellcode:"
	@objcopy -O binary --only-section=.text $(OUT) shellcode.bin
	@hexdump -v -e '"\\x" 1/1 "%02x"' shellcode.bin; echo

clean:
	rm -f $(OUT) $(OBJ) shellcode.bin


#make
#make shellcode 
#make clean     
