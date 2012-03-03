CC=gcc
TARGET = test
C_FLAGS = -g -WALL
LIB_FLAGS=-pthread
all :$(TARGET)
test:test.o
	$(CC) -o $@ $^ $(C_FLAGS) $(LIB_FLAGS)
clean :
	rm *.o *.out *.obj


