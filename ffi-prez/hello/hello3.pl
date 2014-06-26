use strict;
use warnings;

use feature 'say';

use FFI::Raw;

my $hello3 = FFI::Raw->new(
    'libhello.so' => 'hello3',
    FFI::Raw::str
);

say $hello3->();
