#!/usr/bin/env bash
#
# MailScanner installation script for Debian based systems
# 
# This script installs the required software for
# MailScanner via apt-get and CPAN based on user input.  
#
#
# Written by:
# Jerry Benton < mailscanner@mailborder.com >
# 14 MAR 2015

# clear the screen. yay!

# where i started for RPM install
THISCURRPMDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Function used to Wait for n seconds
timewait () {
	DELAY=$1
	sleep $DELAY
}

# Check for root user
if [ $(whoami) != "root" ]; then
	clear
	echo;
	echo "Installer must be run as root. Aborting. Use 'su -' to switch to the root environment."; echo;
	exit 192
fi

# bail if apt-get is not installed
if [ ! -x '/usr/bin/apt-get' ]; then
	clear
	echo;
	echo "apt-get package manager is not installed. You must install this before starting";
	echo "the MailScanner installation process. Installation aborted."; echo;
	exit 192
else
	APTGET='/usr/bin/apt-get';
fi

# basic test to see if we can ping google
if ping -c 1 8.8.8.8 > /dev/null; then
	# got a return on the single ping request
    CONNECTTEST=
else
	# a ping return isn't required, but it may signal a problem with the network connection. this simply warns the user
    CONNECTTEST="WARNING: I was unable to ping outside of your network. \nYou may ignore this warning if you have confirmed your connection is valid."
fi

AUTOUPGRADE=0
CONFFILES=
MTAOPTION="postfix";

SA=1
SAOPTION="spamassassin"

CAV=1
CAVOPTION="clamav-daemon clamav-freshclam clamav-base libclamav-client-perl";

CPANOPTION=1
NODEPS=


# base system packages
BASEPACKAGES="curl wget tar binutils libc6-dev gcc make patch gzip unzip openssl perl perl-doc libdbd-mysql-perl libconvert-tnef-perl libdbd-sqlite3-perl libfilesys-df-perl libmailtools-perl libmime-tools-perl libnet-cidr-perl libsys-syslog-perl libio-stringy-perl perl-modules libdbd-mysql-perl libencode-detect-perl unrar-free antiword libarchive-zip-perl libole-storage-lite-perl libsys-sigaction-perl pyzor razor tnef libinline-perl libmail-imapclient-perl libtest-pod-coverage-perl libfile-sharedir-install-perl libmail-spf-perl libnetaddr-ip-perl libsys-hostname-long-perl libhtml-tokeparser-simple-perl libmail-dkim-perl libnet-ldap-perl libnet-dns-resolver-programmable-perl libnet-cidr-lite-perl libtest-manifest-perl libdata-dump-perl libbusiness-isbn-data-perl libbusiness-isbn-perl";

# the array of perl modules needed
ARMOD=();
ARMOD+=('Archive::Tar'); 		ARMOD+=('Archive::Zip');		ARMOD+=('bignum');				
ARMOD+=('Carp');				ARMOD+=('Compress::Zlib');		ARMOD+=('Compress::Raw::Zlib');	
ARMOD+=('Convert::BinHex'); 	ARMOD+=('Convert::TNEF');		ARMOD+=('Data::Dumper');		
ARMOD+=('Date::Parse');			ARMOD+=('DBD::SQLite');			ARMOD+=('DBI');					
ARMOD+=('Digest::HMAC');		ARMOD+=('Digest::MD5');			ARMOD+=('Digest::SHA1'); 		
ARMOD+=('DirHandle');			ARMOD+=('ExtUtils::MakeMaker');	ARMOD+=('Fcntl');				
ARMOD+=('File::Basename');		ARMOD+=('File::Copy');			ARMOD+=('File::Path');			
ARMOD+=('File::Spec');			ARMOD+=('File::Temp');			ARMOD+=('FileHandle');			
ARMOD+=('Filesys::Df');			ARMOD+=('Getopt::Long');		ARMOD+=('Inline::C');			
ARMOD+=('IO');					ARMOD+=('IO::File');			ARMOD+=('IO::Pipe');			
ARMOD+=('IO::Stringy');			ARMOD+=('HTML::Entities');		ARMOD+=('HTML::Parser');		
ARMOD+=('HTML::Tagset');		ARMOD+=('HTML::TokeParser');	ARMOD+=('Mail::Field');			
ARMOD+=('Mail::Header');		ARMOD+=('Mail::IMAPClient');	ARMOD+=('Mail::Internet');		
ARMOD+=('Math::BigInt');		ARMOD+=('Math::BigRat');		ARMOD+=('MIME::Base64');		
ARMOD+=('MIME::Decoder');		ARMOD+=('MIME::Decoder::UU');	ARMOD+=('MIME::Head');			
ARMOD+=('MIME::Parser');		ARMOD+=('MIME::QuotedPrint');	ARMOD+=('MIME::Tools');			
ARMOD+=('MIME::WordDecoder');	ARMOD+=('Net::CIDR');			ARMOD+=('Net::DNS');			
ARMOD+=('Net::IP');				ARMOD+=('OLE::Storage_Lite');	ARMOD+=('Pod::Escapes');		
ARMOD+=('Pod::Simple');			ARMOD+=('POSIX');				ARMOD+=('Scalar::Util');		
ARMOD+=('Socket'); 				ARMOD+=('Storable'); 	 	 	ARMOD+=('Test::Harness');		
ARMOD+=('Test::Pod');			ARMOD+=('Test::Simple');		ARMOD+=('Time::HiRes');			
ARMOD+=('Time::localtime'); 	ARMOD+=('Sys::Hostname::Long');	ARMOD+=('Sys::SigAction');		
ARMOD+=('Sys::Syslog'); 		ARMOD+=('Env'); 				ARMOD+=('File::ShareDir::Install');

# not required but nice to have
ARMOD+=('bignum');				ARMOD+=('Business::ISBN');		ARMOD+=('Business::ISBN::Data');
ARMOD+=('Data::Dump');			ARMOD+=('DB_File');				ARMOD+=('DBD::SQLite');
ARMOD+=('DBI');					ARMOD+=('Digest');				ARMOD+=('Encode::Detect');
ARMOD+=('Error');				ARMOD+=('ExtUtils::CBuilder');	ARMOD+=('ExtUtils::ParseXS');
ARMOD+=('Getopt::Long');		ARMOD+=('Inline');				ARMOD+=('IO::String');	
ARMOD+=('IO::Zlib');			ARMOD+=('IP::Country');			ARMOD+=('Mail::SPF');
ARMOD+=('Mail::SPF::Query');	ARMOD+=('Module::Build');		ARMOD+=('Net::CIDR::Lite');
ARMOD+=('Net::DNS');			ARMOD+=('Net::LDAP');			ARMOD+=('Net::DNS::Resolver::Programmable');
ARMOD+=('NetAddr::IP');			ARMOD+=('Parse::RecDescent');	ARMOD+=('Test::Harness');
ARMOD+=('Test::Manifest');		ARMOD+=('Text::Balanced');		ARMOD+=('URI');	
ARMOD+=('version');							


# add to array if the user is installing spamassassin
if [ $SA == 1 ]; then
	ARMOD+=('Mail::SpamAssassin');
fi

# logging starts here
(
clear
echo;
echo "Installation results are being logged to mailscanner-install.log";
echo;
timewait 1

# install the basics
echo "Installing required base system utilities ..."; echo;
timewait 2

# install base packages
$APTGET update
$APTGET -yf install $BASEPACKAGES

# install this separate in case it conflicts
if [ "x$MTAOPTION" != "x" ]; then
	$APTGET -yf install $MTAOPTION
fi

# check for curl
if [ ! -x /usr/bin/curl ]; then
	clear
	echo;
	echo "The curl command cannot be found. I have already attempted to install this";
	echo "package, but it is still not found. Please ensure that you have network access";
	echo "to the internet and try running the installation again.";
	echo;
	exit 1
else
	CURL='/usr/bin/curl';
fi

# install required perl packages that are available via apt
#
# some items may not be available depending on the distribution 
# release but those items will be checked after this and installed
# via cpan if the user elected to do so.
clear
echo;
echo "Installing tnef, Clam AV (if elected), and Spamassassin (if elected) via apt ... "; echo;
timewait 3
# the tnef below is a dummy placeholder. leave it there!
$APTGET -y install tnef $CAVOPTION $SAOPTION

# fix the stupid line in /etc/freshclam.conf that disables freshclam 
if [ $CAV == 1 ]; then
	COUT='#Example';
	perl -pi -e 's/Example/'$COUT'/;' /etc/freshclam.conf
fi

# enable spamassassin
if [ $SA == 1 ]; then
	SOUT='ENABLED=1';
	perl -pi -e 's/ENABLED=0/'$SOUT'/;' /etc/default/spamassassin
fi

# create the cpan config if there isn't one and the user
# elected to use CPAN
if [ $CPANOPTION == 1 ]; then
	# user elected to use CPAN option
	if [ ! -f '/root/.cpan/CPAN/MyConfig.pm' ]; then
		echo;
		echo "CPAN config missing. Creating one ..."; echo;
		mkdir -p /root/.cpan/CPAN
		cd /root/.cpan/CPAN
		$CURL -O https://s3.amazonaws.com/mailscanner/install/cpan/MyConfig.pm
		cd $THISCURRPMDIR
		timewait 1
	fi
fi

# now check for missing perl modules and install them via cpan
# if the user elected to do so
clear; echo;
echo "Checking Perl Modules ... "; echo;
timewait 2
# used to trigger a wait if something this missing
PMODWAIT=0

# remediate
if [ $CPANOPTION == 1 ]; then
for i in "${ARMOD[@]}"
do
	perldoc -l $i >/dev/null 2>&1
	if [ $? != 0 ]; then
		clear
		echo "$i is missing. Installing via CPAN ..."; echo;
		timewait 1
		perl -MCPAN -e "CPAN::Shell->force(qw(install $i ));"
	fi
done
fi

# check and notify of any missing modules
for i in "${ARMOD[@]}"
do
	perldoc -l $i >/dev/null 2>&1
	if [ $? != 0 ]; then

		echo "WARNING: $i is missing.";
		PMODWAIT=5

	else
		echo "$i => OK";
	fi
done

# will pause if a perl module was missing
timewait $PMODWAIT

# fix the clamav wrapper if the user does not exist
if [ -f '/etc/freshclam.conf' ]; then
	if id -u clam >/dev/null 2>&1; then
		#clam is being used instead of clamav
		OLDCAVUSR='ClamUser="clamav"';
		NEWCAVUSR='ClamUser="clam"'
	
		OLDCAVGRP='ClamGroup="clamav"';
		NEWCAVGRP='ClamGroup="clam"';
	
		perl -pi -e 's/'$OLDCAVUSR'/'$NEWCAVUSR'/;' /usr/share/MailScanner/clamav-wrapper
		perl -pi -e 's/'$OLDCAVGRP'/'$NEWCAVGRP'/;' /usr/share/MailScanner/clamav-wrapper
		
		freshclam
	fi
fi

# postfix fix
if [ -f "/etc/postfix/master.cf" ]; then
	sed -i "s/pickup    unix/pickup    fifo/g" /etc/postfix/master.cf
	sed -i "s/qmgr      unix/qmgr      fifo/g" /etc/postfix/master.cf
fi

clear
echo;
echo "Installing the MailScanner .deb package ... ";

# install the mailscanner package
dpkg -i $CONFFILES $NODEPS $THISCURRPMDIR/mailscanner-*-noarch.deb

if [ $? != 0 ]; then
	echo;
	echo '----------------------------------------------------------';
	echo 'Installation Error'; echo;
	echo 'The MailScanner package failed to install. Address the required';
	echo 'dependencies and run the installer again.';
	echo;
	echo 'Note that Perl modules need to be available system-wide. A';
	echo 'common issue is that missing modules were installed in a ';
	echo 'user specific configuration.';
	echo;
else
	if [ $AUTOUPGRADE == 1 ]; then
		echo "Upgrading /etc/MailScanner/MailScanner.conf";
		echo;
		echo "Your old configuration file will be saved as:";
		echo "/etc/MailScanner/MailScanner.conf.old.$$";
		echo;
		timewait 1
		
		# fix old style clamav Monitors if preset in old mailscanner.conf
		CAVOLD='Monitors for ClamAV Updates = /usr/local/share/clamav/*.cld /usr/local/share/clamav/*.cvd';
		CAVNEW='Monitors for ClamAV Updates = /usr/local/share/clamav/*.cld /usr/local/share/clamav/*.cvd /var/lib/clamav/*.inc/* /var/lib/clamav/*.?db /var/lib/clamav/*.cvd';
		perl -pi -e 's/'$CAVOLD'/'$CAVNEW'/;' /etc/MailScanner/MailScanner.conf
		
		upgrade_MailScanner_conf /etc/MailScanner/MailScanner.conf /etc/MailScanner/MailScanner.conf.dpkg-dist > /etc/MailScanner/MailScanner.new
		mv -f /etc/MailScanner/MailScanner.conf /etc/MailScanner/MailScanner.conf.old.$$
		mv -f /etc/MailScanner/MailScanner.new  /etc/MailScanner/MailScanner.conf

	fi
	
	echo;
	echo '----------------------------------------------------------';
	echo 'Installation Complete'; echo;
	echo 'See http://www.mailscanner.info for more information and  '
	echo 'support via the MailScanner mailing list.'
	echo;
fi 

) 2>&1 | tee mailscanner-install.log