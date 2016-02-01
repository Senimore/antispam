#!/usr/bin/perl
use strict;
use warnings;

# first, create your message
use Email::MIME;
my $message = Email::MIME->create(
  header_str => [
    From    => 'ars@senimore.local',
    To      => 'ars@senimore.local',
    Subject => 'Happy birthday!',
  ],
  attributes => {
    encoding => 'quoted-printable',
    charset  => 'ISO-8859-1',
  },
#  body_str => "XJS*C4JDBQADN1.NSBN3*2IDNEN*GTUBE-STANDARD-ANTI-UBE-TEST-EMAIL*C.34X\n",
   body_str => 'X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*',
);

# send the message
use Email::Sender::Simple qw(sendmail);
sendmail($message);
