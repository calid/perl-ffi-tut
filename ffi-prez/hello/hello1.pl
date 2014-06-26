use strict;
use warnings;

use FFI::Raw;

my $hello1 = FFI::Raw->new(
    'libhello.so' => 'hello1',  # library => function
    FFI::Raw::void  # return type
    # no args
);

$hello1->call();
$hello1->();  # I like this style
