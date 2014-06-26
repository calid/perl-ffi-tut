use strict;
use warnings;

use FFI::Raw;

my $hello2 = FFI::Raw->new(
    'libhello.so' => 'hello2',
    FFI::Raw::void,
    FFI::Raw::str
);

$hello2->("ohhai");
