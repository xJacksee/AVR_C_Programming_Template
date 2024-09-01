MCU = atmega328p
DUDE_MCU = m328p
PROG = stk500v1
SOURCE = main
PORT = /dev/ttyACM0

upload: hex
	avrdude -c $(PROG) -p $(DUDE_MCUMCU) -P $(PORT) -U flash:w:"./bin/$(NAME).hex":i

hex: compile
	avr-objcopy ./bin/$(SOURCE).elf -O ihex ./bin/main.hex

compile:
	avr-gcc ./src/$(SOURCE).c -o ./bin/$(SOURCE).elf -mmcu=$(MCU) -O1

clean:
	rm ./bin/*.elf && rm ./bin/*.hex
