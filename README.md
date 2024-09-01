# AVR C/C++ Programming Template for Linux
This template provides all necessary basic commands, directory structure and configs for developing C/C++ applications for AVR "bare-metal" microcontrollers and developments boards. It is dedicated for everyone who wants to start from scratch using only basic tools listed below without the help of any framework or IDE.
## Description
All commands responsible for compiling and uploading the code are included in "makefile" that executes them sequentially according to the given task. VS Code is configured JSON files in .vscode directory. These files include directives for code highlighting, autocomplete, tips and error detection dedicated to AVR compiler as well as tasks that can compile, download, verify adn uplad code to MCU. Tasks can be executed in VS Code in "Terminal" tab and one of them can be set as default to be quicly executed by shortcut Ctrl+Shift+B. Alternativly, all the tasks can be executed in terminal by using "make <task>", where every task name and commands can be found in makefile.
## Initial MAKEFILE configuration
Before you start compiling, it is adviced to edit all variables in makefile:
- MCU - name of the microcontroller listed in avr-gcc compiler
- DUDE_MCU - name of the microcontroller listed in avrdude
- PROG - name of used programmed according to avrdude list
- SOURCE - name of the application source code file (without extension)
- PORT - name of the port that the programmer is connected to
## Nessesary tools
 - avr-gcc
 - avrdude
 - make
 - Visual Studio Code
## Author
Szymon Bartosik
