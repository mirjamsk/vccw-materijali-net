Wordpress workflow for materijali.net
=====================================

Table of Contents
-----------------
+ [Setting up local wordpress environment](#setting-up-local-wp-environment-for-the-first-time)  
+ [Sync local wp with github repo](#sync-local-wp-with-github-repo)  
+ [Sync local wp with remote database](#sync-local-wp-with-remote-database)  


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
------------------------------
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

Sync local wp with remote database
----------------------------------
Local and remote databases can be synced using [wordmove](https://github.com/welaika/wordmove)
#### 1. Modify Movefile
Modify Movefile located in algebra-materijali/ to use staging and production environments

#### 2. Vagrant ssh & cd to /vagrant file
```
$ vagrant ssh
$ cd /vagrant
```
#### 3. Sync db records 
```bash
# to sync with production env use -e production
$ wordmove pull -d -e staging	 # pull records from remote host to local machine
$ wordmove push -d -e staging	 # push records from local machine to remote host
```

#### Known errors or issues 

##### SyntaxError
If you get a SyntaxError, check if your Movefile is valid (beware of indentation). Useful link: http://yamllint.com
```bash
...
/usr/local/rbenv/versions/2.1.2/lib/ruby/2.1.0/psych.rb:370:in `parse': (<unknown>): did not find expected key while parsing a block mapping at line 12 column 3 (Psych::SyntaxError)
...
```
---
##### Use absolute paths not ~/
```bash
...
 SCP did not finish successfully (1): scp: ~/apps/devalgebramaterijali/public/wp-content/dump.sql: No such file or directory (Net::SCP::Error)
...
```
---
##### SyntaxError
If you get a SyntaxError, check if your Movefile is valid (beware of indentation). Useful link: http://yamllint.com
```bash
...
/usr/local/rbenv/versions/2.1.2/lib/ruby/2.1.0/psych.rb:370:in `parse': (<unknown>): did not find expected key while parsing a block mapping at line 12 column 3 (Psych::SyntaxError)
...
```
---
##### Encoding error
If an encoding issues occur, try hard-code a fix :( as suggested in [issue #78]( https://github.com/welaika/wordmove/issues/78).
```bash
...
/usr/local/rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/wordmove-1.2.0/lib/wordmove/sql_adapter.rb:44:in `gsub!': invalid byte sequence in US-ASCII (ArgumentError)
...
```

Modify the sql_adapter.rb file bay adding *sql_content.force_encoding("UTF-8")* on line 44 
```bash
$ vagrant ssh
$ cd usr/local/rbenv/versions/2.1.2/lib/ruby/gems/2.1.0/gems/wordmove-1.2.0/lib/wordmove/
$ sudo vi sql_adapter.rb
```

The sql_adapter.rb file should now look something like this:
```ruby
...
    def serialized_replace!(source_field, dest_field)
      length_delta = source_field.length - dest_field.length

      sql_content.force_encoding("UTF-8")
      sql_content.gsub!(/s:(\d+):([\\]*['"])(.*?)\2;/) do |match|
        length = $1.to_i
...
```

[edit-hosts]: http://www.rackspace.com/knowledge_center/article/modify-your-hosts-file
