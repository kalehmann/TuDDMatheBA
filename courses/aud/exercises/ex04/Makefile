CC = gcc
CC_FLAGS = -Wall -g -O0

PROGS = \
	factorial \
	max \
	multiplication_table \
	prime_numbers

all: $(PROGS)

%: %.c
	$(CC) $(CC_FLAGS) -o $@ $<
clean:
	rm -rf $(PROGS)

.PHONY: all clean
