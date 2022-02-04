// Implementierung der Ackermann-Funktion
#include<stdio.h>

unsigned int ackermann(unsigned int x, unsigned int y)
{
	if (0 == x) {
		return y + 1;
	}
	if (0 == y) {
		return ackermann(x - 1, 1);
	}

	return ackermann(x - 1, ackermann(x, y - 1));
}

int main(void)
{
	unsigned int x, y;
	printf("x : ");
	scanf("%d", &x);
	printf("y : ");
	scanf("%d", &y);

	printf("%d\n", ackermann(x, y));
}
