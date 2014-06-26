#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

uint8_t *raw_data(int *data_size)
{
    uint8_t *raw_bytes = "foo\0bar\0baz";
    *data_size         = 11;

    uint8_t *data = malloc(sizeof(uint8_t) * (*data_size));
    memcpy(data, raw_bytes, *data_size);

    return data;
}
