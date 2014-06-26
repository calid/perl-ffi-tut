use strict;
use warnings;

use FFI::Raw;
use feature 'say';

use String::Escape qw(backslash);

my $raw_data = FFI::Raw->new(
    'librawdata.so' => 'raw_data',
    FFI::Raw::ptr,
    FFI::Raw::ptr
);

sub print_raw {
    my $bytes_size     = pack('L!', 0);
    my $bytes_size_ptr = unpack('L!', pack('P', $bytes_size));

    my $bytes_ptr = $raw_data->($bytes_size_ptr);
    $bytes_size   = unpack('L!', $bytes_size);

    my $ffi_ptr = FFI::Raw::MemPtr->new($bytes_size);

    my $memcpy = FFI::Raw->new(
        'libc.so.6' => 'memcpy',
        FFI::Raw::void,
        FFI::Raw::ptr, # dest
        FFI::Raw::ptr, # src
        FFI::Raw::int  # size
    );

    $memcpy->($ffi_ptr, $bytes_ptr, $bytes_size);

    my $bytes = $ffi_ptr->tostr($bytes_size);
    say backslash($bytes);
}

print_raw();
