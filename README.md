#Synopsis

#Code Exemple

#Motivation
## Why this project?
I'm the AIX SysAdmin and I don't like to do every day the same jobs. If something is repetitive, maybe we can write script for that?
This repository hold scripts which I wrote or rewrite from different projects / persons to have all in one place.

## Why OOP (Object-oriented programming?
OOP https://en.wikipedia.org/wiki/Object-oriented_programming) is used in this project as I want to reuse code each time, where it is possible, it is not big difference in code when you want to use
output from "lsmap -npiv" to check if all virtual adapters are logged, you want to compare with older output (for example between reboots during
upgrade of system) or need commands to restore settings (after rebuild of system).
OOP allow also refactoring (https://en.wikipedia.org/wiki/Code_refactoring), you can rebuild big part of code and 
with TDD you are always sure that it works. So maintance of code is much easier and faster.

## Why  Test Driven Developing (TDD)?
AIX systems are typically production systems so each time you change your scripts, you should be sure that it will not hurt your systems.
TDD (https://en.wikipedia.org/wiki/Test-driven_development) will help you to be sure that all classes, scripts etc. will behavior as you expect. TDD is also helping you to define what really you 
want (as you are starting from writting tests ;). Other reason is simple, good tests are really good documentation of your code, it shows how
to use classes and functions and what is expected to get as result. This documentation is always updated ;).


## Why Ruby?
I believe first scripts you were writting in bash/ksh but when project was growning you afraid to change anything as your changes could destroy 
others scripts. So you are ended with big number of small scripts which maintance took longer and longer. Then you started to write it in Perl 
and OOP (Object Oriented programming). Perl is always on AIX machines so you can run scripts on any of your systems. Problem is that OOP on AIX 
is difficult, no internal variables, no isolations etc, so it is time to change base laungauge. 
Why Ruby and not Python or something different? Ruby is used in Chef :). Some part of code can be used in Chef.

## Why Git?
Git allow you to have branches and easy manage versions of project. Main stream have only current and working version of scripts and you don't 
need anymore versioning with numbers like check_interfaces8.rb ;). 

## Why AIX 5.3 not current one like 7.1 or 7.2?
Why I'm using in my tests AIX 5.3 and not current AIX like 7.1 or 7.2? because I got this version with my harware :). 
if you are using newer versions and you are authorized to provide me data to update my scripts I will do it. 
if you known how to really buy newer version of this software please write to me. I was trying to contact sellers but they ignored me :).

I will use some example data found on Ineternet (maunal pages, example data, posts etc) but I can't quarantee that it will be working on your setup.



#Installation



#API Reference

#Tests

#Contributors

#License
GPL
