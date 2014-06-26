typedef int (*print_fp)(char *s);

int runcb(print_fp cb, char *msg)
{
    return cb(msg);
}
