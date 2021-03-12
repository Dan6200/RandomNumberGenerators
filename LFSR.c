# include <stdint.h>
# include <stdio.h>

void main(void)
{
    uint8_t start_state = 0xFFu;  /* A nonzero start state. */
    uint8_t lfsr = start_state;
    uint8_t bit;                    
    unsigned period = 0;

    do
    {   /* taps: 8 6 5 4; feedback polynomial: x^8 + x^6 + x^5 + x^4 + 1 */
        bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 4));
        lfsr = (lfsr >> 1) | (bit << 7);
        ++period;
    }
    while (lfsr != start_state);

    printf("%d\n",period);
}
