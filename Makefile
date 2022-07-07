##
## EPITECH PROJECT, 2021
## B-ASM-400-NAN-4-1-asmminilibc-victor.harri-chal
## File description:
## Makefile
##

SRC		=	my_strlen.asm \
				my_strchr.asm \
				my_strrchr.asm \
				my_memset.asm \
				my_memcpy.asm \
				my_memmove.asm \
				my_strcmp.asm \
				my_strncmp.asm

NAME	=	libasm.so

OBJ		=	$(SRC:.asm=.o)

CC		=	ld

ASM 	=	nasm

RM 		= 	rm -f

ASFLAGS =	-felf64

LDFLAGS =	-fPIC -shared

all:	$(NAME)

$(NAME):	$(OBJ)
				$(CC) $^ $(LDFLAGS) -o $@
				$(RM) $(OBJ)

%.o: %.asm
				$(ASM) $(ASFLAGS) $< -o $@

clean:
			$(RM)	$(OBJ)

fclean:	clean
			$(RM) 	$(NAME)

re:	fclean all

.PHONY: all clean fclean re
