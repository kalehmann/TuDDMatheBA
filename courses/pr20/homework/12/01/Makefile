CC = gfortran
CC_FLAGS = -Wall -g -O3

MODS = \
	mod_matmul.o \

PROG = aufgabe_22

all: $(PROG)

%.o: %.f95
	$(CC) $(CC_FLAGS) -c -o $@ $<

$(PROG): $(PROG).f95 $(MODS)
	$(CC) $(CC_FLAGS) -o $@ $< $(MODS)

clean:
	rm -rf $(MODS) $(PROG)

.PHONY: all clean
