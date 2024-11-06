# AVR programming make file

# Compilation and programming variables
MCU = atmega328p 		# Microcontroller name according to avr-gcc compiler list of supported devices
DUDE_MCU = m328p		# Microcontroller name according to avrdude list of supported devices
PROG = stk500v1			# Programmer name according to avrdude list of supported programmers
SOURCE = main			# Main C/C++ source file name (without extension; change extension to .cpp in commands below if using C++)
PORT = /dev/ttyACM0		# Serial/Pararell port that programmer is connected to
BAUD = 19200			# Baud rate used by a programmer (wrong setting can result in "out of sync" or "0x00 device signature" errors)
LOG = avrdude			# Name of a log file that will contain verbose (-v) output and summary of avrdude action
F_CPU = 1000000UL		# CPU clock speed in Hz (UL - unsigned long)

# Upload application
upload: compile
	avrdude -v -C /etc/avrdude.conf -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l ./log/$(LOG).log -U flash:w:"./bin/$(SOURCE).hex":i

# Compile source code to .hex and .elf binary format
compile:
	avr-gcc ./src/$(SOURCE).c -o ./bin/$(SOURCE).elf -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Wall -O1
	avr-objcopy ./bin/$(SOURCE).elf -O ihex ./bin/main.hex

# Remove compiled output files and logs
clean:
	rm ./bin/*.elf && rm ./bin/*.hex && rm ./log/*.log
