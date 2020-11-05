CC = gfortran
CC_FLAGS = -Wall

PROGS = \
	loop01 \
	loop02 \
	loop03 \
	loop04 \
	loop05

all: $(PROGS)

%: %.f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(PROGS)

.PHONY: all clean
