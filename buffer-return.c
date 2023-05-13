#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static uid_t euid, ruid;

int sanitize(char *input){
	char buffer[64]; // If more than 8 characters input
	strcpy(buffer, input);
	printf("strcpy() executed...\n");
}

int main(int argc, char * argv[]) {
	int status;

	if(argc < 2) {
		printf("Not enough arguments....\n");
		exit(0);
	}  
	sanitize(argv[1]);

        if (argc < 2){
		printf("You should NEVER see this!\n");
        } else{
		printf("You should ALWAYS see this!\n");
	}

	return 0;
}


