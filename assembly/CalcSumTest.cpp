#include <stdio.h>


int calc_sum_test(int a, int b, int c) {
    return a + b + c;
}

int _tmain(int argx, char* argv[]) {
    int a = 17;
    int b = 11;
    int c = 14;
    int sum = calc_sum_test(a, b, c);
    
    printf("a: %d\n", a);
    printf("b: %d\n", b);
    printf("c: %d\n", c);
    printf("sum: %d\n", sum);
    return 0;
}
