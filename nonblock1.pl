#nonblock1.pl

use strict;
use warnings;
use feature 'say';

use ZMQ::FFI;
use ZMQ::FFI::Constants qw(ZMQ_PUSH ZMQ_PULL);

use AnyEvent;
use EV;

my $endpoint = "ipc://zmq-ffi-$$";
my $ctx      = ZMQ::FFI->new();

my $push = $ctx->socket(ZMQ_PUSH);
$push->connect($endpoint);

my $pull = $ctx->socket(ZMQ_PULL);
$pull->bind($endpoint);

my $recvd = 0;
my $w = AE::io $pull->get_fd, 0, sub {
    while ($pull->has_pollin) {
        print $pull->recv();

        $recvd++;
        if ( $recvd == 3 ) {
            EV::unloop;
            print "\n";
        }
        else {
            print '.';
        }
    }
};

my $t = AE::timer 0, 0, sub {
    $push->send($_) for $push->version;
};

EV::run;
