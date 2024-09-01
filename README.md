# AVR C/C++ Programming Template for Linux
This template provides all necessary basic commands, directory structure and configs for developing C/C++ applications for AVR "bare-metal" microcontrollers and developments boards. It is dedicated for everyone who wants to start from scratch using only basic tools listed below without the help of any framework or IDE.
## Description
All commands responsible for compiling and uploading the code are included in "makefile" that executes them sequentially according to the given task. VS Code is configured JSON files in .vscode directory. These files include directives for code highlighting and autocomplete dedicated to AVR compiler as well as tasks that can compile, download, verify and uplad code to MCU with single click. Tasks can be executed in VS Code in "Terminal" tab and one of them can be set as default to be quickly executed by shortcut Ctrl+Shift+B. Alternativly, all the tasks can be executed in terminal by using "make <task>", where every task name and commands can be found in makefile.
## Initial MAKEFILE configuration
Before you start compiling, it is adviced to edit all variables in makefile according to their comments.
## Dependencies
 - avr-gcc                      (AVR compiler)
 - avrdude                      (AVR downloader and uploader)
 - make                         (build tool)
 - Visual Studio Code           (editor)
 - "C/C++" VS Code Extension    (code highlighting)
## Author
Szymon Bartosik
