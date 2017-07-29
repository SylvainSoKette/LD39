## [Hello there !](https://www.youtube.com/watch?v=rEq1Z0bjdwc)
I am currently making this game for Ludum Dare 39 !
Everything will most likely change a lot until the Compo deadline, but you can already try it now if you're bored :)

## Requirements
The game was built using [Haxe](https://haxe.org/download/) 3.4.1

You'll also need :
* flixel 4.3.0
* lime 2.9.1
* openfl 3.6.1

After installing haxe (Windows users, make sure that Haxe and Haxelib are in your %PATH% by just trying to run 'haxe' and 'haxelib' in your command prompt)
```
haxelib install flixel
```

This part should be optional (flixel should install all of them) :
```
haxelib install lime
haxelib install openfl
```

But this part is **super important** and not optional ! :
```
haxelib set lime 2.9.1
haxelib set openfl 3.6.1
```

## Run the game
Open a terminal/command prompt and go to the game directory
```
haxelib run lime run "Project.xml" neko -debug
```

## Compile
Also in the game directory, you can build the game to your platform

(You'll need a compiler installed for that)
```
haxelib run lime run "Project.xml" PLATFORM -debug
```
PLATFORM can be :
* mac
* linux
* windows