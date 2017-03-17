#include <stdio.h>

extern "C" int calc_sum_(int a, int b, int c);

int main(int argc, char* argv[]) {
    int a = 17;
    int b = 11;
    int c = 14;
    int sum = calc_sum_(a, b, c);
    
    printf("a: %d\n", a);
    printf("b: %d\n", b);
    printf("c: %d\n", c);
    printf("sum: %d\n", sum);
    return 0;
}