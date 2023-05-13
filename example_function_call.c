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
	function(0x0000000a,0x000000bb,0x00000ccc, 0x0000dddd, 0x000eeeee, 0x00ffffff, 0x11111110, 0x22222200, 0x33333000, 0x44440000, 0x55500000,"Hello world!");
	printf("Result: %li\n",result);
	return 0;
}


