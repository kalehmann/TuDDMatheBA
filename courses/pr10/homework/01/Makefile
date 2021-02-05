CC = gfortran
CC_FLAGS = -Wall

PROGS = \
	potenz_a \
	potenz_b \
	potenz_c \
	potenz_d \
	fakultaet \
	RoundingError

all: $(PROGS)

%: %.f95
	$(CC) $(CC_FLAGS) -o $@ $<

clean:
	rm -rf $(PROGS)

.PHONY: all clean
