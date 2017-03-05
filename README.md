Wordpress workflow for the tech blog
=====================================

Table of Contents
-----------------
+ [Setting up local wordpress environment](#setting-up-local-wp-environment-for-the-first-time)  
+ [Sync local wp with github repo](#sync-local-wp-with-github-repo)  
+ [Sync local wp with remote database](#sync-local-wp-with-remote-database)  
+ [Workflow](#workflow)  


Setting up local wp environment for the first time
--------------------------------------------------
The original [instructions](http://vccw.cc/) have been modified a bit to better suit the particular needs of developing our tech blog.

You can *skip* any steps if you already have the required software installed on your machine. 


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
	127.0.0.1  tech-blog.dev
	```

#### 5. Download and extract .zip or .tag.gz
https://github.com/mirjamsk/vccw-materijali-net/releases/tag/tech-blog-0.4

This will be your development directory so extract the .zip into a meaningful location and rename the root directory from vccw-materijali-net-x.x to algebra-materijali

#### 6. Change into the new directory
```
$ cd tech-blog
```

#### 7. Start a Vagrant environment
```
$ vagrant up
```
<sup>Tip: you might be asked for your user account password</sup>

#### 8. Check if everything is up and running
Visit http://tech-blog.dev/ or http://192.168.33.10/

#### 9. Check email with MailCatcher
MailCathcer re-routes all WordPress emails to Mailcatcher.
Just visit visit http:/tech-blog.dev:1080/ or http://192.168.33.10:1080/

#### 10. When you're done developing
When you're done developing locally, always stop vagrant using the command 
```
$ vagrant halt
```
<sup>Tip: you might be asked for your user account password</sup>


Sync local wp with github repo
------------------------------
#### 1. Change into the algebra-materijali/www/public directory
```
$ cd wwww/public
```
#### 2. Run the following commands
```bash
# remove all files part from wp-config.php
$ shopt -s extglob
$ rm -rf !(wp-config.php|.htaccess)
$ shopt -u extglob
# git setup
$ git init
$ rm .gitignore
$ git remote add origin https://github.com/mirjamsk/techblog.git
$ git pull origin master
```

Sync local wp with remote database
----------------------------------
Local and remote databases can be synced using [wordmove](https://github.com/welaika/wordmove)
#### 1. Modify Movefile
Modify Movefile located in tech-blog/ to use staging and production environments

#### 2. Vagrant ssh & cd to /vagrant file
```
$ vagrant ssh
$ cd /vagrant
```
#### 3. Deal with the encoding issue ([see wiki][wordmove-encoding-fix-wiki])
```bash
$ sudo cp /vagrant/sql_adapter.rb  /usr/local/rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/wordmove-1.2.0/lib/wordmove/sql_adapter.rb
```

#### 4. Sync db records 
```bash
$ wordmove pull -d -e staging	
```
That's it!

---

Workflow
----------------------------------
#### Environments
We are using 3 environments:
+ local
+ staging http://staging.tech-blog.ml (for testing new features and development in general)
+ production http://tech-blog.ml (where our live site lives)

#### Code versioning
The code is pulled and pushed via git.
To update server code you need to connect to the server via ssh (see evernote for details)

#### Sync db records 
```bash
# to sync with production environment use -e production
$ wordmove pull -d -e staging	 # pull records from remote host to local machine
$ wordmove push -d -e staging	 # push records from local machine to remote host
```


[edit-hosts]: http://www.rackspace.com/knowledge_center/article/modify-your-hosts-file
[wordmove-encoding-fix-wiki]:https://github.com/mirjamsk/vccw-materijali-net/wiki/Known-errors,-issues-&-fixes#encoding-error
