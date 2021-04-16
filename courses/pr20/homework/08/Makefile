CC = gfortran
CC_FLAGS = -Wall

PROGS = \
	connect_four

all: $(PROGS)

%: %.f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(PROGS)

.PHONY: all clean
