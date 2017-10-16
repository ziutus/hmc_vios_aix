# Synopsis

# Code Exemple
ping_all.rb -s server1,server2

# Motivation
## Why this project?
I'm the AIX SysAdmin and I don't like to do every day the same jobs. If something is repetitive, maybe we can write script for that?
This repository hold scripts which I wrote or rewrite from different projects / persons to have all in one place.

## Why OOP (Object-oriented programming) for SA (System Administrators)?
OOP is used in this project as I want to reuse code each time, where it is possible, 
it is not big difference in code when you want to use
output from "lsmap -npiv" to check if all virtual adapters are logged, you want to compare with older output (for example between reboots during
upgrade of system) or need commands to restore settings (after rebuild of system).
OOP allow also refactoring (https://en.wikipedia.org/wiki/Code_refactoring), you can rebuild big part of code and 
with TDD you are always sure that it works. So maintenance of code is much easier and faster.

## Why  Test Driven Developing (TDD)?
AIX systems are typically production systems so each time you change your scripts, you should be sure that it will not hurt your systems.
TDD will help you to be sure that all classes, scripts etc. will behavior as you expect. TDD is also helping you to define what really you 
want (as you are starting from writing tests ;). Other reason is simple, good tests are really good documentation of your code, it shows how
to use classes and functions and what is expected to get as result. This documentation is always updated ;).

## Why Ruby?
I believe first scripts you were writing in bash/ksh but when project was growing you afraid to change anything as your changes could destroy 
others scripts. So you are ended with big number of small scripts which maintenance took longer and longer. Then you started to write it in Perl 
and Object Oriented programming (OOP). Perl was always on AIX machines so you can could scripts on any of your systems. Problem is that OOP in Perl 
is difficult: no internal variables, no isolation etc, so it is time to change base language. 

Why Ruby and not Python or something different? Ruby is used in Chef :). Some part of code can be used in Chef.


## Why AIX 5.3 not current one like 7.1 or 7.2?
Why I'm using in my tests AIX 5.3 and not current AIX like 7.1 or 7.2? because I got this version with my hardware :). 
if you are using newer versions and you are authorized to provide me data to update my scripts I will do it. 
If you known how to really buy newer version of this software please write to me. I was trying to contact sellers but they ignored me :).

I will use some example data found on Internet (manual pages, example data, posts etc) but I can't promise that it will be working on your setup.

# Installation
Needed ruby games:
* json
* dns-ruby
* net-ssh
* net-ping
* test-unit
* shoulda-context

if you want to add libraries to your path, you can use below code:

```
export RUBYLIB="/home/ziutus/github/hmc_vios_aix-master/inc:/home/ziutus/ruby_local/inc"
```

Configuration file with default data for HMC script (hmc_manage.rb) should provide data like: hmc IP or name, user on HMC and password. It is yaml file. 
Example of config:

```
:hmc: 192.168.200.33
:username: hscroot
:password: TopSecretPasswordAbc1234
```

# API Reference

# Tests
In this project we are using Unit Tests. All tests are in /t directory. if you want to run one test, just call:
```
ruby hmc_lpar_profile.rb -n test_profile_decode_6
```

# Contributors

# License
GPL