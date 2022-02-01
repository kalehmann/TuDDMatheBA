// A program that outputs the prime numbers from 1 to 1000.
#include<stdio.h>

/**
 * Checks if a number (> 2) is a prime.
 */
unsigned int is_prime(unsigned int n)
{
	unsigned int i;
	if (0 == n % 2) {
		return 0;
	}
	for (i = 3; i <= n / 3 + 1; i = i + 2) {
		if (0 == n % i) {
			return 0;
		}
	}

	return 1;
}

int main(void)
{
	unsigned int i;
	printf("The prime numbers from 1 to 1000 are:\n  2\n");
	for (i = 3; i < 1000; i++) {
		if (is_prime(i)) {
			printf("%3d\n", i);
		}
	} 
	
	return 0;
}
