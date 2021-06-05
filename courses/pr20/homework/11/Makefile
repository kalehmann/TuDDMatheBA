CC = gfortran
CC_FLAGS = -Wall -g -O0

MODS = \
	stringmod.o \
	treemod.o

PROG = taschenrechner

all: $(PROG)

%.o: %.f95
	$(CC) $(CC_FLAGS) -c -o $@ $<

$(PROG): $(PROG).f95 $(MODS)
	$(CC) $(CC_FLAGS) -o $@ $< $(MODS)

clean:
	rm -rf $(MODS) $(PROG)

.PHONY: all clean
