CC = gfortran
CC_FLAGS = -Wall -g -O3

PROG = aufgabe_23

all: $(PROG)

$(PROG): $(PROG).f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(MODS) $(PROG)

.PHONY: all clean
