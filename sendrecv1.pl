#sendrecv1.pl

use strict;
use warnings;
use feature 'say';

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REQ ZMQ_REP);

my $endpoint = "ipc://zmq-ffi-$$";
my $ctx      = ZMQ::FFI->new();
my $version  = join '.', $ctx->version;

my $req = $ctx->socket(ZMQ_REQ);
$req->connect($endpoint);

my $rep = $ctx->socket(ZMQ_REP);
$rep->bind($endpoint);

$req->send($version);
say $rep->recv();
