use strict;
use warnings;

use FFI::Raw;
use feature 'say';

my $raw_data = FFI::Raw->new(
    'librawdata.so' => 'raw_data',
    FFI::Raw::str,
    FFI::Raw::ptr
);

sub print_raw {
    my $raw_size     = pack('L!', 0);
    my $raw_size_ptr = unpack('L!', pack('P', $raw_size));

    my $bytes = $raw_data->($raw_size_ptr);
    say $bytes;
}

print_raw();
