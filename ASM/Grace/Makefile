NAME = Grace
ASM = nasm
ASFLAGS = -g -f elf64
LD = gcc -no-pie

SRC = Grace.s
OBJ = Grace.o

all: $(NAME)

$(NAME): $(OBJ)
	$(LD) -o $@ $<

$(OBJ): $(SRC)
	$(ASM) $(ASFLAGS) -o $@ $<

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) Grace_kid.s

re: fclean all

.PHONY: all clean fclean re
