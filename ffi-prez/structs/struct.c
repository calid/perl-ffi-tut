#include <stdio.h>

struct data {
    char **strs;
    int    n_strs;
};

void print_struct(struct data *d)
{
    puts("struct.strs:");

    for ( int i = 0; i < d->n_strs; i++ ) {
        printf("\t%s\n", d->strs[i]);
    }
}
