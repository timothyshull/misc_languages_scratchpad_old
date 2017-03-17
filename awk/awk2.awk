#!/usr/local/bin/awk -f

BEGIN {
    printf("One line\n")
    printf("Two lines\n")
    printf("\n")
    while (getline <"poem.txt" > 0) {
        printf("%s\n", $1)
        printf("%s\n", $0)
        printf("%s\n", $2)
    }
    close("poem.txt")
    exit
}
END {
    printf("\treturn 0;")
}