MCU = atmega328p
DUDE_MCU = m328p
PROG = stk500v1
SOURCE = main
PORT = /dev/ttyACM0
BAUD = 19200
LOG = avrdude

upload: compile
	avrdude -v -C /etc/avrdude.conf -c $(PROG) -p $(DUDE_MCU) -P $(PORT) -b $(BAUD) -l ./log/$(LOG).log -U flash:w:"./bin/$(SOURCE).hex":i

compile:
	avr-gcc ./src/$(SOURCE).c -o ./bin/$(SOURCE).elf -mmcu=$(MCU) -O1
	avr-objcopy ./bin/$(SOURCE).elf -O ihex ./bin/main.hex

clean:
	rm ./bin/*.elf && rm ./bin/*.hex
