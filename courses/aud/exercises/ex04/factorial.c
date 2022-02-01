// A program, that outputs the factorial of a given number.

#include <stdio.h>

int main(void)
{
	int f = 1, n;
	printf("Insert n : ");
	scanf("%d", &n);
	if (n < 1) {
		printf("Unexpected negative number\n");

		return 1;
	}
	for (;n > 1; n--) {
		f *= n;
	}
	printf("n! = %d\n", f);

	return 0;
}

