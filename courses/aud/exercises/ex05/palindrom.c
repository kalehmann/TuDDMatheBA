// Checks if a given string is a palindrom
#include<stdio.h>
#include<string.h>

void readstr(char* str, unsigned int max_len)
{
	char c;
	unsigned int i = 0;
	while('\n' != (c = getchar()) && i < max_len - 1) {
		str[i++] = c;
	}

	str[i] = 0;
}

unsigned int palindrom(char* str, unsigned int n)
{
	unsigned int i;
	for (i = 0; i <= n / 2; i++) {
		if (str[i] != str[n - i - 1]) {
			return 0;
		}
	}

	return 1;
}

int main(void)
{
	char str[256];
	printf("String (max 255 characters) : ");
	readstr(str, 256);
	if (palindrom(str, strlen(str))) {
		printf("Your string is a palindrome\n");
	} else {
		printf("Your string is no palindrome\n");
	}

	return 0;
}

