
CC=$(M)-gcc
LD=$(M)-ld
STRIP=$(M)-strip

ELFS := bind_shell reverse_shell
SOS  := bind_shell.so reverse_shell.so

.PHONY: all
all: clean $(ELFS) $(SOS)

.PHONY: strip
strip: $(ELFS) $(SOS)
	$(STRIP) $^

.PHONY: clean
clean:
	rm -f $(ELFS) $(SOS) *.o

bind_shell: bind_shell.c
	$(CC) --static bind_shell.c -o bind_shell

reverse_shell: reverse_shell.c
	$(CC) --static -O0 reverse_shell.c -o reverse_shell

reverse_shell.so: reverse_shell.o
	$(LD) -shared -static $< -o $@ -lm

reverse_shell.o: reverse_shell_so.c
	$(CC) -fPIC -c -O0 $< -o $@

bind_shell.so: bind_shell.o
	$(LD) -shared -static $< -o $@ -lm

bind_shell.o: bind_shell_so.c
	$(CC) -fPIC -c -O0 $< -o $@
	
