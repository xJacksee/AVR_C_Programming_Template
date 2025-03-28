# AVR makefile for C/C++

# Paths
#==============================================================================================================================================================
SOURCE_PATH = ./src/
LIB_PATH = ./lib/
INCLUDE_PATH = ./inc/
BIN_PATH = ./bin/
LOG_PATH = ./log/
#==============================================================================================================================================================

# Compiler varaibles
#==============================================================================================================================================================
MCU = atmega328p
C_STD = c11
CC_FLAGS = -Wall -O1 -g
OUTPUT = main
SOURCES = $(SOURCE_PATH)main.c
BOOTLOADER = $(BIN_PATH)
#==============================================================================================================================================================

# Uploader variables
#==============================================================================================================================================================
CONFIG_FILE = /etc/avrdude.conf
DUDE_MCU = m328P
PROG = stk500v1
PORT = /dev/ttyACM0
BAUD = 19200
FLASH_LOG = flash_upload
FUSE_LOG = fuses_upload
BOOT_LOG = bootloader_upload

LOW_FUSE = 0x62
HIGH_FUSE = 0xD9
EXT_FUSE = 0xFF
LOCK_FUSE = 0xFF
#==============================================================================================================================================================

# Actions
#==============================================================================================================================================================
# Compile source code to .hex and .elf binary format (change avr-gcc to avr-g++ if using C++)
compile:
	avr-gcc $(SOURCES) -o $(BIN_PATH)$(OUTPUT).elf -mmcu=$(MCU) -I $(INCLUDE_PATH) -L $(LIB_PATH) -std=$(C_STD) $(CC_FLAGS)
	avr-objcopy $(BIN_PATH)$(OUTPUT).elf -O ihex $(BIN_PATH)$(OUTPUT).hex

# Remove compiled output files and logs
clean:
	rm $(BIN_PATH)*.elf && rm $(BIN_PATH)*.hex && rm $(LOG_PATH)*.log

# Setup fuses
fuse:
	avrdude -v -C $(CONFIG_FILE) -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l $(LOG_PATH)$(FUSE_LOG).log \
	-U lfuse:w:$(LOW_FUSE):m -U hfuse:w:$(HIGH_FUSE):m -U efuse:w:$(EXT_FUSE):m -U lock:w:$(LOCK_FUSE):m

# Burn bootloader
bootloader:
	avrdude -v -C $(CONFIG_FILE) -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l $(LOG_PATH)$(BOOT_LOG).log \
	-U flash:w:"$(BIN_PATH)$(BOOTLOADER).hex":i

# Upload application
upload: compile
	avrdude -v -C $(CONFIG_FILE) -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l $(LOG_PATH)$(FLASH_LOG).log \
	-U flash:w:"$(BIN_PATH)$(OUTPUT).hex":i
#==============================================================================================================================================================