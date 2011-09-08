#include <iostream>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

double root(long n) {
    return sqrt(n + 0.25) + 0.5;
}

void problem100(long max) {
    for (long j = 1; true; j++) {
        long val = j * (j - 1);
        double b = root(val / 2);
        if (floor(b) == ceil(b)) {
            std :: cout << j << " " << (long)b << "\n";
            if (j > max) {
                break;
            }
        }
    }
}

int main()
{
     problem100(1e12);
}
