================================================================
|    ###    ###    ###    ###    #  #   #####   ####   ###     |
|    #  #   #  #    #    #       #  #     #     #      #  #    |
|    ###    ###     #    #  ##   ####     #     ##     ###     |
|    #  #   #  #    #    #   #   #  #     #     #      #  #    |
|    ###    #  #   ###    ###    #  #     #     ####   #  #    |
================================================================

Brighter

created by
Jakob Mendelsohn
Bernike de Olde
Gijsbert Havinga
Marijn Metzlar


-----------------------
Running the Game
-----------------------
In order to run the game, simply execute the Brighter.exe file, found in \export\windows\neko\bin\
The controls should be explained in the game, but can also be checked in the options menu, which can be opened by clicking on the menu button in the top left corner and then selecting "Opties".
WARNING: The "Terug" button leads back to the main menu, erasing all progress. To close the menu simply click on the bird again.

-----------------------
Compiling the Game
-----------------------
In order to compile the game first the libraries "flixel" and "flixel-addons" need to be installed using haxelib.
Then the game can be compiled for neko using the "release" flag. If using the "debug" flag, certain features like double jumping in the first level and resetting the PlayState using the Backspace key will be enabled.
The game can also be compiled for flash and opened with Google Chrome, but in that case the music and sound files are not supported.