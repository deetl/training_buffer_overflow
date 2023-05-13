#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long function(long a, long b, long c, long d, long e, long f, long g, long h, long i, long j, long k, char *input){
	long result1;
	long result2;
	long result;
	result1 = a+b+c+d+e+f;
	result2 = g+h+i+j+k;
	result=result1 +result2;
	return(result);
	
}

int main(int argc, char * argv[]) {
	long result;
	function(0x0000000a,0x000000b0,0x00000c00, 0x0000d000, 0x000e0000, 0x00f00000, 0x00000001, 0x00000020, 0x00000300, 0x00004000, 0x00050000,"Hello world!");
	printf("Result: %li\n",result);
	return 0;
}


