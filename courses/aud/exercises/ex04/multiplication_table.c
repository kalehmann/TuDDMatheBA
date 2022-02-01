// A program that outputs the multiplication table from 1 to n for a given n.

#include <stdio.h>

void print_row(unsigned int i, unsigned int n)
{
	unsigned int j;
	printf("┃ %2d ┃", i);
	for (j = 1; j < n; j++) {
		printf(" %2d │", i * j);
	}
	printf(" %2d ┃\n", i * n);
}

int main(void)
{
	unsigned int i, n;
	printf("Print multiplication table from 1 to : ");
	scanf("%d", &n);
	printf("┏━━━━┳");
	for (i = 1; i < n; i++) {
		printf("━━━━┳");
	}
	printf("━━━━┓\n");
	printf("┃  * ┃");
	for (i = 1; i <= n; i++) {
		printf(" %2d ┃", i);
	}
	printf("\n┣━━━━╋");
	for (i = 1; i < n; i++) {
		printf("━━━━╇");
	}
	printf("━━━━┫\n");
	for (i = 1; i <= n; i++) {
		print_row(i, n);
	}
	printf("┗━━━━┻");
	for (i = 1; i < n; i++) {
		printf("━━━━┷");
	}
	printf("━━━━┛\n");

	return 0;
}
