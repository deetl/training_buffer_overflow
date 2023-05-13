#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sanitize(char *input){
	long tmp;
	char buffer[8]; // If more than 8 characters input
	
	printf("Setting tmp to 0xf0f0f0f0deadbeef\n");
	tmp = 0xf0f0f0f0deadbeef;
	
	strcpy(buffer, input);
	printf("strcpy() executed...\n");
	
	if (tmp != 0xf0f0f0f0deadbeef){
		printf("You should never see this!\n");
	}
}

int main(int argc, char * argv[]) {
	short tmp;
	if(argc < 2) {
		printf("Not enough arguments....\n");
		exit(0);
	}
	sanitize(argv[1]);
	return 0;
}


