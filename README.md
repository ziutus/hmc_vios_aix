#Synopsis

#Code Exemple

#Motivation
## Why this project?
I'm the AIX SysAdmin and I don't like to do every day the same jobs. If something is repetitive, maybe we can write script for that?
This repository hold scripts which I wrote or rewrite from different projects / persons to have all in place.

## Why OOP (Object-oriented programming [link] https://en.wikipedia.org/wiki/Object-oriented_programming)?
OOP is used in this project as I want to reuse code each time, where it is possible, it is not big difference in code when you want to use
output from "lsmap -npiv" to check if all virtual adapters are logged, you want to compare with older output (for example between reboots during
upgrade of system) or need commands to restore settings (after rebuild of system).
OOP allow also refactoring (link https://en.wikipedia.org/wiki/Code_refactoring), you can rebuild big part of code and 
with TDD you are always sure that it works. So maintance of code is much easier and faster.

## Why TDD (Test Driven Developing [link]https://en.wikipedia.org/wiki/Test-driven_development)?
AIX systems are typically production systems so each time you change your scripts, you should be sure that it will not hurt your systems.
TDD will help you to be sure that all classes, scripts etc. will behavior as you expect. TDD is also helping you to define what really you 
want (as you are starting from writting tests ;). Other reason is simple, good tests are really good documentation of your code, it shows how
to use classes and functions and what is expected to get as result. This documentation is always updated ;).


## Why Ruby?
I believe first scripts you was writting in bash/ksh but when project is growning you afraid to change anything as your changes can destroy others scripts.
So you are ending with big number of small scripts which maintance take longer and longer. Then you can start to write it in Perl and OOP (Object
Oriented programming). Perl is always on AIX machines so you can run scripts on any of your systems. Problem started as OOP on AIX is difficult, no 
internal variables, no isolations etc, so it was time to change base laungauge. 
Why Ruby and not Python or something different? Ruby is used in Chef :). Some part of code can be used in Chef.

## Why Git?
Git allow you to have branches and easy manage versions of project. Main stream have only current and working version of scripts and you don't 
need anymore versioning with numbers like check_interfaces8.pl ;). 


#Installation



#API Reference

#Tests

#Contributors

#License
GPL
