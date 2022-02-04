CC = gcc
CC_FLAGS = -Wall -g -O0 -fsanitize=address

PROGS = \
	ackermann \
	palindrom

all: $(PROGS)

%: %.c
	$(CC) $(CC_FLAGS) -o $@ $<
clean:
	rm -rf $(PROGS)

.PHONY: all clean
