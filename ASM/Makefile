# Top-level Makefile for the Assembly implementations.
# Delegates to each program's own Makefile (Colleen, Grace, Sully).

DIRS = Colleen Grace Sully

all:
	@for d in $(DIRS); do $(MAKE) -C $$d || exit 1; done

clean:
	@for d in $(DIRS); do $(MAKE) -C $$d clean; done

fclean:
	@for d in $(DIRS); do $(MAKE) -C $$d fclean; done

re: fclean all

.PHONY: all clean fclean re
