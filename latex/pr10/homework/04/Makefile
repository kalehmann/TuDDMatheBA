CC = gfortran
CC_FLAGS = -Wall

PROGS = \
	fibonacci \
	kreis \
	syntax

all: $(PROGS)

%: %.f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(PROGS)

.PHONY: all clean
