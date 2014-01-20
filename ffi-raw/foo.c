#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include <stdio.h>

uint8_t *foo_bytes(int *data_size)
{
    uint8_t *raw_bytes = "foo\0bar\0baz";
    *data_size         = 11;

    uint8_t *data = malloc(sizeof(uint8_t) * (*data_size));
    memcpy(data, raw_bytes, *data_size);

    return data;
}
