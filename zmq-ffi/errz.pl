#errz.pl

use strict;
use warnings;
use feature 'say';

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REQ ZMQ_REP);

my $ctx = ZMQ::FFI->new();
my $s = $ctx->socket(-1);
$s->connect('bogus');
