pharo-EJDB 
======

[Pharo](https://www.pharo.org) bindings for https://github.com/Softmotions/ejdb

Install
-------

### Building EJDB library

- You need to download the library sources and compile it for your platform, from here: https://github.com/Softmotions/ejdb
- You can place it along with your image or with your VM plugins

### Installing pharo-ejdb in your image
Then, you can install it executing:

```Smalltalk
Metacello new 
	repository: 'github://pharo-nosql/pharo-ejdb';
	baseline: 'EJDB';
	load.
```
