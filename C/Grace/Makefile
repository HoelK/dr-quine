CC=cc
NAME=Grace
CFLAGS=-Wall -Wextra -Werror
OBJ=Grace.o

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -rf *.o

fclean: clean
	rm -rf $(NAME) Grace_kid.c

re: fclean all

.PHONY: all clean fclean re
