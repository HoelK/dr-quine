# Convenience top-level Makefile: builds both the C and ASM implementations.

DIRS = C ASM

all:
	@for d in $(DIRS); do $(MAKE) -C $$d || exit 1; done

clean:
	@for d in $(DIRS); do $(MAKE) -C $$d clean; done

fclean:
	@for d in $(DIRS); do $(MAKE) -C $$d fclean; done

re: fclean all

.PHONY: all clean fclean re
