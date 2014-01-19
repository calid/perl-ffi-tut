use strict;
use warnings;
use FFI::Raw;
use feature 'say';

# first
#my $foo_bytes = FFI::Raw->new(
    #'libfoo.so' => 'foo_bytes',
    #FFI::Raw::str,
    #FFI::Raw::ptr
#);

#sub print_foo {
    #my $foo_size     = pack('L!', 0);
    #my $foo_size_ptr = unpack('L!', pack('P', $foo_size));

    #my $bytes = $foo_bytes->($foo_size_ptr);
    #say $bytes;
#}

#print_foo();

# second
#use String::Escape qw(backslash);

#my $foo_bytes = FFI::Raw->new(
    #'libfoo.so' => 'foo_bytes',
    #FFI::Raw::ptr,
    #FFI::Raw::ptr
#);

#sub print_foo {
    #my $bytes_size     = pack('L!', 0);
    #my $bytes_size_ptr = unpack('L!', pack('P', $bytes_size));

    #my $bytes_ptr = $foo_bytes->($bytes_size_ptr);
    #$bytes_size   = unpack('L!', $bytes_size);

    #my $ffi_ptr = FFI::Raw::MemPtr->new($bytes_size);

    #my $memcpy = FFI::Raw->new(
        #'libc.so.6' => 'memcpy',
        #FFI::Raw::void,
        #FFI::Raw::ptr, # dest
        #FFI::Raw::ptr, # src
        #FFI::Raw::int  # size
    #);

    #$memcpy->($ffi_ptr, $bytes_ptr, $bytes_size);

    #my $bytes = $ffi_ptr->tostr($bytes_size);
    #say backslash($bytes);
#}

#print_foo();

# third
use String::Escape qw(backslash);

my $foo_bytes = FFI::Raw->new(
    'libfoo.so' => 'foo_bytes',
    FFI::Raw::ptr,
    FFI::Raw::ptr
);

sub print_foo {
    my $bytes_size     = pack('L!', 0);
    my $bytes_size_ptr = unpack('L!', pack('P', $bytes_size));

    my $bytes_ptr = $foo_bytes->($bytes_size_ptr);
    $bytes_size   = unpack('L!', $bytes_size);

    my $ffi_ptr = FFI::Raw::MemPtr->new($bytes_size);

    my $memcpy = FFI::Raw->new(
        'libc.so.6' => 'memcpy',
        FFI::Raw::void,
        FFI::Raw::ptr, # dest
        FFI::Raw::ptr, # src
        FFI::Raw::int  # size
    );

    my $free = FFI::Raw->new(
        'libc.so.6' => 'free',
        FFI::Raw::void,
        FFI::Raw::ptr
    );

    $memcpy->($ffi_ptr, $bytes_ptr, $bytes_size);

    my $bytes = $ffi_ptr->tostr($bytes_size);
    say backslash($bytes);

    $free->($bytes_ptr);
}

print_foo();
