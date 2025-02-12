# AVR programming makefile

# Paths
SOURCE_PATH = ./src/
HEADER_PATH = ./headers
LIB_PATH = ./lib/
BIN_PATH = ./bin/
LOG_PATH = ./log/

# Compiler varaibles
SOURCES = $(SOURCE_PATH)main.c
OUTPUT = main

MCU = atmega328p
COMPILER_FLAGS = -mmcu=$(MCU) -Wall -O1 -I $(HEADER_PATH)

# Uploader variables
CONFIG_FILE = /etc/avrdude.conf
DUDE_MCU = m328P
PROG = stk500v1
PORT = /dev/ttyACM0
BAUD = 19200
FLASH_LOG = flash_upload
FUSE_LOG = fuses_upload

# Fuse settings
LOW_FUSE = 0x62
HIGH_FUSE = 0xD9
EXT_FUSE = 0xFF
LOCK_FUSE = 0xFF

# Upload application
upload: compile
	avrdude -v -C /etc/avrdude.conf -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l $(LOG_PATH)$(LOG).log -U flash:w:"$(BIN_PATH)$(OUTPUT).hex":i

# Compile source code to .hex and .elf binary format (change avr-gcc to avr-g++ if using C++)
compile:
	avr-gcc $(SOURCES) -o $(BIN_PATH)$(OUTPUT).elf $(COMPILER_FLAGS)
	avr-objcopy $(BIN_PATH)$(OUTPUT).elf -O ihex $(BIN_PATH)$(OUTPUT).hex

# Remove compiled output files and logs
clean:
	rm $(BIN_PATH)*.elf && rm $(BIN_PATH)*.hex && rm $(LOG_PATH)*.log

# Setup fuses
fuse:
	avrdude -v -C $(CONFIG_FILE) -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l ./log/$(LOG).log -U lfuse:w:$(LOW_FUSE):m -U hfuse:w:$(HIGH_FUSE):m -U efuse:w:$(EXT_FUSE):m -U lock:w:$(LOCK_FUSE):m