# Recoil

A runner game where you move your character with the recoil of your shots. Made to be played on a navigator using Haxeflixel.

## Getting Started

This is a one person project so I'll be the only one working on this version. Of course you're welcome to use some of the code for your own projects or enhance this one.

### Introduction

#### The 'story'

You're an american cosmonaut soldier send to outer space to destroy communist satellites. But beware if you hit an asteroid or a satellite you will die. Try to destroy the maximum and survive the longest time possible.
(Of course since I haven't done any graphical assets yet, it will require a bit more imagination to link the story with the game)

#### How to play

The game is supposed to handle controller output in its final state but for the moment you can only use your mouse. Move your mouse to aim and use the left click to shoot, beware you'll be propelled in the opposite direction.

### Purpose of the game

My main goals with this game were :

* To gain experience in game developpment and learn how to use HaxeFlixel
* To have a project to showcase
* Hopefully to help other people learning flixel to solve some problems they may have or just to understand how it works better

If you want to play the game you have two options :

* Go on my website and play the web version (unfortunatly this website doesn't exists yet, wich leaves you with option two)
* Clone the repo, download Haxeflixel and play it on your computer

### Prerequisites

The prerequisite depend if you want to play it on the web or on your computer.

Since there isn't any web version yet you will have to download the project and test it from your pc.

First you need **[Haxe](https://haxe.org/)** and **[HaxeFlixel](http://haxeflixel.com/)**. You have a guide on how to install both of these on your computer **[here](http://haxeflixel.com/documentation/getting-started/)**.



### Installing

All you have to do is clone the repo, if you have haxeflixel you'll be able to launch the game.


### Launching the game

Depending on the way you want to play the game you can use different command lines. First go in the game directory :

`cd /somewhere/game_folder/`


* if you want to play it on the neko VM just type in
	`lime test neko`

* if you want to launch it on your browser in HTML5
	`lime test html5`

* if you want to launch it on your browser in flash
	`lime test flash`

## To Do list

Programming tasks :

* add shot cooldown

* adjust hitboxes

* add controller support

* try endless recoil

Other :

* change/adjust sound effects

* create graphical assets

## Built with

* [Haxe](https://haxe.org/) - The Cross-Platform Toolkit
* [HaxeFlixel](http://haxeflixel.com/) - Free, cross-platform 2D game engine powered by Haxe and OpenFL

## Authors

* **Arthur Cendrier** - Development and graphical assets - [ashtrail](https://github.com/ashtrail)

## License

This project is licensed under the Apache License - see the [LICENSE](https://github.com/ashtrail/Recoil/blob/master/LICENSE) file for details.

## Acknowledgments

Thanks to the HaxeFlixel team for their great library, tutorials and examples !
