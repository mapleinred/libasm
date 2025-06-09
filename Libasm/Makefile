# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: xzhang <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/11/19 13:26:08 by xzhang            #+#    #+#              #
#    Updated: 2023/12/26 12:57:33 by xzhang           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#Variables
NAME   = libasm.a

SRCS = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
BONUS_SRC = ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
OBJS = $(SRCS:.s=.o)
#BONUS_OBJ = $(BONUS_SRC:.s=.o)

NASM = nasm
NASMFLAGS = -f elf64
AR = ar rcs

#nasm is 
# MAIN = 
# LIBFLAGS = -lreadline
# HEADER = -Iinclude

# LIBFT = ./libft/libft.a
# LIB_DIR = libft

CC     = gcc
RM     = rm -rf
CFLAGS = -Wall -Wextra -Werror -MMD -MP

# Main targets
all: ${NAME}

$(NAME): $(OBJS)
	@echo "Building $(NAME)..."
	$(AR) $(NAME) $(OBJS)

# $(LIBFT):
# 	make re -C ./libft

# $(OBJS): $(SRCS)
# 	cc $(CFLAGS) -c $(SRCS) $(INCLUDES)

%.o: %.s
	@echo "Assembling $<..."
	$(NASM) $(NASMFLAGS) $< -o $@

test: $(NAME)
	@echo "Building test program..."
	$(CC) $(CFLAGS) main.c -L. -lasm -o test_program
	@echo "Running tests..."
	@./test_program

# test_bonus: $(NAME)
# 	$(CC) main_bonus.c -L. -lasm -o test_bonus

clean:
	@echo "Cleaning object files..."
	${RM} $(OBJS) $(BONUS_OBJ)

fclean: clean
	@echo "Removing $(NAME)..."
	${RM} $(NAME)
# test_bonus

re: fclean all

.PHONY: all clean fclean re test
