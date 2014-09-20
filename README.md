# ClipperZ gitted demo

[ClipperZ](https://clipperz.is/) is a web Password Manager where data
is encrypted by Javascript on the client browser. HTTPS is not needed.
Data is stored in a MySQL database and the PHP app does not manipulate
any clear data, as data is decrypted by the client Javascript.

This repository contains:
* ```mysql```: MySQL dumps of ClipperZ data

* ```sysconf```: [Sysconf](https://github.com/geonef/sysconf.base/)
  definition to build the
  [Gitted](https://github.com/geonef/sysconf.gitted)-enabled system
  with MySQL, Nginx, php5-fpm and settings for import/export the
  data.


## Get started

**You don't need to be root!** but you need [Git](http://git-scm.com/)
and [LXC](https://linuxcontainers.org/) installed on your Linux
system. See [Gitted](https://github.com/geonef/sysconf.gitted) for
more information.

```
git clone https://github.com/jfgigand/data-clipperz.git && cd data-clipperz
sysconf/gitted-client register && sysconf/gitted-client add gitted-clipperz
git push gitted-clipperz master
```

The ```git push gitted-clipperz master``` command creates the LXC
container, install ClipperZ and the required packages (from
```sysconf/```) and import the data (from ```mysql/```).


### Export / backup changes

From the ```data-clipperz``` directory you have cloned:
```
git pull gitted-clipperz master
```

It's as simple as that. Now you can make a ```git push origin
master``` to propagate the changes to the upstream remote, or any
other remote, as usual with Git.
