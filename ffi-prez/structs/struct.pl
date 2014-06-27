use strict;
use warnings;
use FFI::Raw;

# the $strs aref can't be passed directly
# otherwise they exist in a temporary scope
# and the pointers will be to garbage memory
my $strs = ["foo", "bar", "baz"];

my ($packed_n, $packed_strs) = pack_strs($strs);

my $struct =
    $packed_strs . # 8 bytes
    $packed_n      # 4 bytes
    ; # 12 bytes total

my $struct_ptr = FFI::Raw::MemPtr->new_from_buf($struct, 12);

my $print_struct = FFI::Raw->new(
    'libstruct.so' => 'print_struct',
    FFI::Raw::void,
    FFI::Raw::ptr
);

$print_struct->($struct_ptr);

sub pack_strs {
    my $strs = shift;

    my @str_ptrs;
    for my $s (@$strs) {
        # get pointer to str and convert to numerical address
        # e.g. char*
        push @str_ptrs, unpack('L!', pack('p', $s));
    }

    my $n_strs  = scalar(@$strs);

    # gen pack format and create list of ptr addresses
    # e.g. list of char*
    my $ptr_list_fmt = 'L!' x $n_strs;
    my $ptr_list = pack($ptr_list_fmt, @str_ptrs);

    # finally get ptr to list itself, pack, and return
    # e.g. char**
    my $packed_s = pack('P',  $ptr_list);
    my $packed_n = pack('i!', $n_strs);

    return ($packed_n, $packed_s);
}
