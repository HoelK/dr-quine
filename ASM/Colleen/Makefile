NAME = Colleen
ASM = nasm
ASFLAGS = -g -f elf64
LD = gcc -no-pie

SRC = Colleen.s
OBJ = Colleen.o

all: $(NAME)

$(NAME): $(OBJ)
	$(LD) -o $@ $<

$(OBJ): $(SRC)
	$(ASM) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
