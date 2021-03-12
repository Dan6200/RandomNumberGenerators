# include <stdint.h>
# include <stdio.h>
# include <limits.h>

void main(void)
{
    uint64_t start_state = 0xFFu;  /* A nonzero start state. */
    uint64_t lfsr = start_state;
    uint64_t bit;                    
    unsigned long period = 0;

    do
    {   /* taps: 64 44 33; feedback polynomial: x^64 + x^44 + x^33 + 1 */
        bit = ((lfsr >> 0) ^ (lfsr >> 20) ^ (lfsr >> 31));
        lfsr = (lfsr >> 1) | (bit << 63);
        ++period;
		if (period == UINT_MAX + 10ull) break;
    }
    while (lfsr != start_state);

    printf("%llu\n",period);
}
