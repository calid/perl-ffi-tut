#include <stdio.h>

void hello1(void)
{
    puts("hello1");
}

void hello2(char *s)
{
    printf("hello2: %s\n", s);
}

char *hello3(void)
{
    return "hello3";
}
