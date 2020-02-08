
CC=$(M)-gcc

bind_shell: bind_shell.c
	$(CC) --static bind_shell.c -o bind_shell

reverse_shell: reverse_shell.c
	$(CC) --static -O0 reverse_shell.c -o reverse_shell
	
all: bind_shell reverse_shell

clean:
	rm bind_shell reverse_shell
	
