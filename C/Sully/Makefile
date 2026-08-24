CC=cc
NAME=Sully
CFLAGS=-Wall -Wextra -Werror
OBJ=Sully.o

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS)

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	rm -rf *.o

fclean: clean
	rm -rf $(NAME) Sully_*

re: fclean all
