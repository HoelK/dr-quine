NAME=Sully
ASM=nasm
ASFLAGS=-g -f elf64
LD=gcc -no-pie

SRC=Sully.s
OBJ=Sully.o

all: $(NAME)

$(NAME): $(OBJ)
	$(LD) -o $@ $<

$(OBJ): $(SRC)
	$(ASM) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) Sully_*

re: fclean all

.PHONY: all clean fclean re
