#include <iostream>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

double root(long n) {
    return sqrt(n + 0.25) + 0.5;
}

void problem100(long min) {
    for (long j = min; true; j++) {
        long val = j * (j - 1);
        double b = root(val / 2);
        if (floor(b) == ceil(b)) {
            std :: cout << j << " " << (long)b << " " << (j * (j - 1)) / (b * (b - 1)) << "\n";
            break;
        }
    }
}

int main()
{
     problem100(1e12);
}
