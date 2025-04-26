CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = code1
TARGET2 = code2
all: $(TARGET) $(TARGET2)
$(TARGET): $(TARGET).o
	$(CC) $(CFLAGS) $^ -o $@
$(TARGET).o: $(TARGET).c
	$(CC) $(CFLAGS) -c $< -o $@
$(TARGET2): $(TARGET2).o
	$(CC) $(CFLAGS) $^ -o $@
$(TARGET2).o: $(TARGET2).c
	$(CC) $(CFLAGS) -c $< -o $@



clean:
	rm *.o $(TARGET)
	rm *.o $(TARGET2)
.PHONY: all clean