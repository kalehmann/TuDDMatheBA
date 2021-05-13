CC = gfortran
CC_FLAGS = -Wall

PROGS = \
	aufgabe01 \
	aufgabe02 \
	aufgabe03

all: $(PROGS)

%: %.f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(PROGS)

.PHONY: all clean
