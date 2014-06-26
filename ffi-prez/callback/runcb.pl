use strict;
use warnings;

use feature 'say';

use FFI::Raw;

sub print_cb {
    my $msg = shift;

    say "print_cb: $msg";

    return length($msg);
}

my $ffi_cb = FFI::Raw::callback(
    \&print_cb,    # coderef
    FFI::Raw::int, # ret type
    FFI::Raw::str  # arg(s)
);

my $runcb = FFI::Raw->new(
    'libruncb.so' => 'runcb',
    FFI::Raw::int,
    FFI::Raw::ptr,
    FFI::Raw::str
);

my $msglen = $runcb->($ffi_cb, "ohhai");

say "msglen: $msglen";
