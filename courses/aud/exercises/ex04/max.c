// A program that reads two numbers and outputs the larger one.

#include <stdio.h>

int main(void)
{
	int m, n;
	printf("Insert first number : ");
	scanf("%d", &m);
	printf("Insert second number : ");
	scanf("%d", &n);
	if (m > n) {
		printf("The first number (%d) is larger\n", m);
	} else if (m == n) {
		printf("Both numbers are equal\n");
	} else {
		printf("The second number (%d) is larger\n", n);
	}

	return 0;
}
