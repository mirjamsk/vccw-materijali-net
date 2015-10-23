Wordpress workflow for materijali.net
=====================================

Table of Contents
-----------------
+ [Setting up local wordpress environment](#setting-up-local-wp-environment-for-the-first-time)  
+ [Sync local wp with github repo](#sync-local-wp-with-github-repo)  

Setting up local wp environment for the first time
--------------------------------------------------
The original [instructions](http://vccw.cc/) have been modified a bit to better suit the particular needs of developing algebra.materijali.dev.

You can skip any steps if you already have the required software installed on your machine. 


#### 1. Install VirtualBox 4.3 or later
https://www.virtualbox.org/

#### 2. Install Vagrant 1.5 or later
http://www.vagrantup.com/

#### 3. Download vagrant box
```
$ vagrant box add miya0001/vccw
```

#### 4. Modify the hosts file
+ If you're using OSX or Linux this can be done automatically for you using the vagrant-hostsupdater plugin 

    ```
    $ vagrant plugin install vagrant-hostsupdater
    ```
+ If your're using Windows or just feel like doing it manually, you need to [edit your hosts file][edit-hosts] by adding the following lines:

 	```
	127.0.0.1  192.168.33.10  
	127.0.0.1  algebra.materijali.dev
	```

#### 5. Download and extract .zip 
https://github.com/mirjamsk/vccw-materijali-net/archive/0.1.zip

This will be your development directory so extract the .zip into a meaningful location and rename the root directory from vccw-materijali-net-x.x to algebra-materijali

#### 6. Change into the new directory
```
$ cd algebra-materijali
```

#### 7. Start a Vagrant environment
```
$ vagrant up
```
<sup>Tip: you might be asked for your user account password</sup>

#### 8. Check if everything is up and running
Visit http://algebra.materijali.dev/ or http://192.168.33.10/

#### 9. Check email with MailCatcher
MailCathcer re-routes all WordPress emails to Mailcatcher.
Just visit visit http://algebra.materijali.dev:1080/ or http://192.168.33.10:1080/

#### 10. When you're done developing
When you're done developing locally, always stop vagrant using the command 
```
$ vagrant halt
```
<sup>Tip: you might be asked for your user account password</sup>


Sync local wp with github repo
--------------------------------------------------
#### 1. Change into the algebra-materijali/www/public directory
```
$ cd wwww/public
```
#### 2. Run the following commands
```bash
# remove all files part from wp-config.php
$ shopt -s extglob
$ rm -rf !(wp-config.php)
$ shopt -u extglob
# git setup
$ git init
$ rm .gitignore
$ git remote add origin https://github.com/mirjamsk/algebra-materijali.git
$ git pull origin master
```


[edit-hosts]: http://www.rackspace.com/knowledge_center/article/modify-your-hosts-file
