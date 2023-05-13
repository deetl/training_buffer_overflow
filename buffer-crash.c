#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

int sanitize(char *input){
	char buffer[8]; // If more than 8 characters input

	strcpy(buffer, input);
	printf("strcpy() executed...\n");
	
}

int main(int argc, char * argv[]) {
	if(argc < 2) {
		printf("Not enough arguments....\n");
		exit(0);
	}
	sanitize(argv[1]);
	return 0;
}


