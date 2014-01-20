#sendrecv2.pl

use strict;
use warnings;
use feature 'say';

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_REQ ZMQ_REP);

my $endpoint = "ipc://zmq-ffi-$$";

# send using 2.x context
my $req_ctx     = ZMQ::FFI->new( soname => 'libzmq.so.1' );
my $req_version = join '.', $req_ctx->version;

my $req = $req_ctx->socket(ZMQ_REQ);
$req->connect($endpoint);
$req->send($req_version);

# receive using 4.x context
my $rep_ctx     = ZMQ::FFI->new( soname => 'libzmq.so.3' );
my $rep_version = join '.', $rep_ctx->version;

my $rep = $rep_ctx->socket(ZMQ_REP);
$rep->bind($endpoint);

say join " ",
    $rep_version, "context",
    "received message from",
    $rep->recv(), "context";
