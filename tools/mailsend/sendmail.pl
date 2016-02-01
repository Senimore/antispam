#!/usr/bin/env perl

use strict;
use warnings;

use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP ();
use Email::Simple ();
use Email::Simple::Creator ();

my $smtpserver = '192.168.56.51';
my $smtpport = '10000';
my $smtpuser   = '';
my $smtppassword = '';

my $transport = Email::Sender::Transport::SMTP->new({
  host => $smtpserver,
  port => $smtpport,
  sasl_username => $smtpuser,
  sasl_password => $smtppassword,
});

my $email = Email::Simple->create(
  header => [
    To      => 'ars@senimore.local',
    From    => 'alfresco@megair.ru',
    Subject => 'test',
  ],
  body => "This is test message\n",
);

sendmail($email, { transport => $transport });