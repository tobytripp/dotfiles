sudo apt-get build-dep netatalk
sudo apt-get install cracklib2-dev fakeroot libssl-dev
sudo apt-get source netatalk
cd netatalk-2*


sudo DEB_BUILD_OPTIONS=ssl dpkg-buildpackage -rfakeroot

sudo dpkg -i ~/netatalk_2*.deb

echo "netatalk hold" | sudo dpkg --set-selections

sudo nano /etc/default/netatalk

# ATALKD_RUN=no
# PAPD_RUN=no
# CNID_METAD_RUN=yes
# AFPD_RUN=yes
# TIMELORD_RUN=no
# A2BOOT_RUN=no

sudo nano /etc/netatalk/afpd.conf

# - -transall -uamlist uams_randnum.so,uams_dhx.so -nosavepassword -advertise_ssh

sudo nano /etc/netatalk/AppleVolumes.default

# ~/ "$u" allow:username1,username2 cnidscheme:cdb

# /home/username/TimeMachine TimeMachine allow:username1,username2 cnidscheme:cdb options:usedots,upriv

# /home/username/TimeMachine TimeMachine allow:username1,username2 cnidscheme:cdb options:usedots

sudo /etc/init.d/netatalk restart

#avahi daemon to advertise services like bonjour
sudo apt-get install avahi-daemon
sudo apt-get install libnss-mdns

sudo nano /etc/nsswitch.conf

# hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4 mdns

sudo nano /etc/avahi/services/afpd.service


HowTo: Make Ubuntu A Perfect Mac File Server And Time Machine Volume [Update6]

by Matthias Kretschmann

4 years ago

Ubuntu Mac File Server ConnectivityFor quite some time I use my Ubuntu machine as a file and backup server for all Macs in my network which is perfectly accessible from the Finder in Mac OS X. There are some instructions available in the web for this task but all failed in my case so I wrote my own tutorial with all the steps needed for it to work properly.

So here’s my little Tutorial for connecting Mac OS X Leopard with Ubuntu and using your Ubuntu machine as a backup volume for Time Machine but all steps can be reproduced on every Linux box and they work with Mac OS X 10.4 Tiger too. At the end of this tutorial you will have a server which shows up in the Finder sidebar and behaves just like a Mac server when accessing it from your Macs. To be perfectly integrated with Mac OS X we’re going to use Apple’s Filing Protocol (AFP) for network and file sharing.

Although this Tutorial involves using the Terminal in Ubuntu and looks a bit geeky it’s very easy even for beginners. I have tried to explain all steps and Terminal commands so you may learn a bit about the Terminal too. At the end of the article you can download my Server Displays icon pack quickly made by me with custom icons for a Mac, Ubuntu and Windows server.

Personally I use a fresh installation of Ubuntu 8.04 Hardy Heron Desktop version (32bit on one machine, 64bit on the other) and Mac OS X Leopard (10.5.3 and later) to connect to them. On my Ubuntu boxes there’s no other file sharing protocol like samba (Windows sharing) or NFS activated.

Update 12/07/2008:
Rumors are Apple will add some undocumented AFP commands with the Mac OS X 10.5.6 update which therefor won’t be supported by the current Netatalk package (and maybe never will). So be sure to check the latest comments on this article when the 10.5.6 update is out to see if this rumor is true and if there are problems caused by that.

Here are the steps involved in setting up your Ubuntu box as a Mac file server:

    Modify and install Netatalk (Open Source AFP implementation)
    Configure Netatalk
    Configure shared volumes (and Time Machine volume)
    Install Avahi (Open Source Bonjour implementation)
    Configure Avahi and advertise services
    Configure TimeMachine
    Conclusion, Problems and more informations
    Downloading and using the Server Display Icons
    Translations Of This Article

1. Modify and install Netatalk

Netatalk iconNetatalk is the Open Source implementation of AFP. Mac OS X requires encryption to work properly but the standard package of netatalk provided in the Ubuntu repositories doesn’t include this feature. So we have to build our own netatalk package from the sources with the encryption feature enabled.

First you have to enable the Source Code repositories via System > Administration > Software Sources under the Ubuntu Software tab. Check the Source Code Box, click Close and choose Reload in the next dialogue.

Source Code Repositories

Update 09/28/2008: Alessandro has built a nice .deb package for i386 machines. Although written in italian you can follow the necessary code snippets for installing this package in his blog post. If the install package works for you just skip the following self compiling process and head over to the Configure Netatalk section.

Now fire up your Terminal under Applications > Accessories and execute the following lines (separately). You have to type Y for yes when Terminal asks you if it should continue:

sudo apt-get build-dep netatalk
sudo apt-get install cracklib2-dev fakeroot libssl-dev
sudo apt-get source netatalk
cd netatalk-2*

Now you have downloaded the source code of Netatalk to your home folder, installed some required packages for building Netatalk and changed the directory to the downloaded folder.

Next you have to build the Netatalk package with the encryption option enabled:

sudo DEB_BUILD_OPTIONS=ssl dpkg-buildpackage -rfakeroot

Depending on your hardware this may take a while but you can enjoy the geeky build output in your Terminal:

Building Netatalk

If everything went through without errors (except the signing warnings, can be ignored) you can install the recently created package:

sudo dpkg -i ~/netatalk_2*.deb

To stop Ubuntu from overwriting your custom Netatalk package you should set its state to hold. This will cause the Netatalk package being grayed out in the Software Update dialogue:

echo "netatalk hold" | sudo dpkg --set-selections

Now you have successfully build and installed your custom Netatalk package which now has support for encrypted logins. Now let’s configure the whole thing.
2. Configure Netatalk

Netatalk iconFirst you should deactivate services provided by Netatalk which are not needed if you just want to use your Ubuntu box for file sharing. This will speed up the response and startup time of Netatalk dramatically. For instance Netatalk starts the old AppleTalk protocol by default which is just needed for pre OS X systems. So we’re going to use the graphical editor gedit for stopping unneeded services:

sudo gedit /etc/default/netatalk

gedit should pop up with the defined file loaded as superuser (needed for saving). Find the “#Set which daemons to run” part and replace the default values with these to enable just AFP and disable all unneeded services. Let the cnid_meta daemon run too and if you want to share your Linux connected printer with your Mac also enable the pap daemon (set to yes):

ATALKD_RUN=no
PAPD_RUN=no
CNID_METAD_RUN=yes
AFPD_RUN=yes
TIMELORD_RUN=no
A2BOOT_RUN=no

Here it’s very important to run the cnid_meta daemon because this service will handle all the metadata for us (namely the reosurce fork) which would get lost due to the fact that your Linux box isn’t formatted as Apple’s HFS+. If you’re interested what the other services could do: atalkd is the AppleTalk daemon (pre-OSX file sharing, old printing), timelord can make your Linux box a network time server and please don’t ask me for what a2boot is good for (If you know it, post it in the comments please / Kelly suggests it’s a netboot server for client Macs).

Press Ctrl + S to save the document or choose File > Save. Next we have to edit the main config file for AFP sharing called afpd.conf:

sudo gedit /etc/netatalk/afpd.conf

Scroll to the very bottom of the document and add this to the bottom (replace the whole line in case there’s already one). This is one line so be sure that there’s no line break in your afpd.conf file:

- -transall -uamlist uams_randnum.so,uams_dhx.so -nosavepassword -advertise_ssh

Press Ctrl + S to save the document or choose File > Save.
3. Configure shared Volumes

Time Machine Volume iconNow we have to tell the afpd daemon what Volumes to share. This is defined in the AppleVolumes.default file inside /etc/netatalk/. The following line will open this file in the gedit editor with superuser privileges (required for saving) where we can define our shared volumes:

sudo gedit /etc/netatalk/AppleVolumes.default

Scroll to the bottom of the document and define your Volume shares. By adding the following line you will share each users home directory with the user name as the Volume name. To make things more secure you can define all users who are allowed to connect to your Ubuntu box via AFP:

~/ "$u" allow:username1,username2 cnidscheme:cdb

Because we want to use the Ubuntu machine as a backup server for Time Machine you should define a second volume just for Time Machine. Create a new folder in your home directory first and name it TimeMachine (or anything you like). Then add the following line to your AppleVolumes.default. This is one line so be sure that there’s no line break in your AppleVolumes.default file:

/home/username/TimeMachine TimeMachine allow:username1,username2 cnidscheme:cdb options:usedots,upriv

Thanks to tsanga for pointing out the usedots and upriv options. The usedots option is required if you want to use invisible files and folders (those starting with a dot in the name). Otherwise afpd would encode them as :2e which is bad if you have to use invisible files (like .htaccess). If you’re on Leopard and have no Tiger installed Macs in your network or mixed OS X versions in your network you should use the upriv option which adds support for AFP3 unix privileges. If you have Macs with Tiger installed just use options:usedots to avoid unexpected behavior:

/home/username/TimeMachine TimeMachine allow:username1,username2 cnidscheme:cdb options:usedots

Finally if you want more stability and can accept slower file transfers you can use the dbd cnidscheme (cnidscheme:dbd).

Press Ctrl + S to save the document or choose File > Save. Of course you can define every folder you like or even an attached USB disk. Just define the correct path. External drives in Ubuntu should be found under /media

Finally restart Netatalk to activate the changes:

sudo /etc/init.d/netatalk restart

Although we now have a fully configured AFP file server it will not show up in the Finder sidebar on Mac OS X Leopard (but it’s reachable via Go > Connect to Server… in the Finder). Macs use a service called Bonjour for the sidebar thing (and for a lot of other cool stuff) and on the Linux side we can have this functionality with the Open Source implementation of Bonjour, called Avahi.
4. Install Avahi

Bonjour iconSo the Avahi daemon will advertise all defined services across your network just like Bonjour do. So let’s install the avahi daemon and the mDNS library used for imitating the Bonjour service. When fully configured this will cause all Macs in your network to discover your Ubuntu box automatically:

sudo apt-get install avahi-daemon
sudo apt-get install libnss-mdns

To make everything work properly you have to edit the nsswitch.conf file:

sudo gedit /etc/nsswitch.conf

Just add “mdns” at the end of the line that starts with “hosts:”. Now the line should look like this:

hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4 mdns

Press Ctrl + S to save the document or choose File > Save.
5. Configure Avahi and advertise services

Bonjour iconNext we have to tell Avahi which services it should advertise across the network. In our case we just want to advertise AFP sharing. This is done by creating a xml-file for each service inside /etc/avahi/services/ following a special syntax. Let’s create a xml-file for the afpd service with the following line:

sudo gedit /etc/avahi/services/afpd.service

A blank document should open in gedit. Now paste the following into the document and save the file by pressing Ctrl + S or by choosing File > Save:


# <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
# <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
# <service-group>
# <name replace-wildcards="yes">%h</name>
# <service>
# <type>_afpovertcp._tcp</type>
# <port>548</port>
# </service>
# <service>
# <type>_device-info._tcp</type>
# <port>0</port>
# <txt-record>model=Xserve</txt-record>
# </service>
# </service-group>

sudo /etc/init.d/avahi-daemon restart