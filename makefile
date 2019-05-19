# makefile for Encryption testing on crypto branch! See the github:
# https://github.com/rlcaust/Fund-O-C

##############################################
# Defining make macros:
#
# wildcard function from make, searches through
# current directory for files matching *.c
#
# SRC:.c=.o is a pattern naming all *.c files found
# to *.o files
#
# $@ is target & $^ is dependency(s)
##############################################

LINK_TARGET = main.exe
LINK_SRC  = $(wildcard *.c)

STATIC_LIB_TARGET = libCrypto.a
STATIC_LIB_SRC = $(wildcard crypto/*.c)

OBJS = $(LINK_SRC:.c=.o)
STATIC_OBJS = $(STATIC_LIB_SRC:.c=.o)

CFLAGS = -Wall -Werror -ansi -g

##############################################
#	 Compile all (default make command)
##############################################
all : $(LINK_TARGET)

$(LINK_TARGET) : libraries
	gcc $(CFLAGS) -o $@ $(LINK_SRC) $(STATIC_LIB_TARGET) -lm
	@echo ======================== All done! =============

##############################################
#	 Compile libraries (static)
##############################################
libraries : $(STATIC_OBJS)
	ar -rcs $(STATIC_LIB_TARGET) encrypt.o util.o
	@echo ============= Libraries compilled! =============

$(STATIC_OBJS) : $(STATIC_LIB_SRC)
	gcc $(CFLAGS) -c $^ -lm

##############################################
#	Clean directory
##############################################
.PHONY : clean
clean :
	rm -f $(OBJS) $(LINK_TARGET) $(STATIC_LIB_TARGET)
	@echo ============== Clean all complete! =============