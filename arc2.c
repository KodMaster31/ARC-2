#include <stdio.h>
#include <string.h>
#include <stdlib.h>

unsigned char RAM[4] = {0};
unsigned char ACC = 0;
unsigned char PC = 0;

void run_asm() {
    PC = 0;
    int limit = 0;
    while (PC < 4 && limit < 20) {
        unsigned char op = RAM[PC];
        unsigned char arg = RAM[PC+1];

        if (op == 0) { // LOAD
            ACC = arg;
        } 
        else if (op == 1) { // ADD
            ACC = (ACC + arg) % 4;
        } 
        else if (op == 2) { // STR
            RAM[arg % 4] = ACC;
        } 
        else if (op == 3) { // OUT
            printf("OUT: %d\n", ACC);
        }

        PC += 2;
        limit++;
    }
}

int get_op(char *s) {
    if (strcmp(s, "LOAD") == 0) return 0;
    if (strcmp(s, "ADD") == 0)  return 1;
    if (strcmp(s, "STR") == 0)  return 2;
    if (strcmp(s, "OUT") == 0)  return 3;
    return -1;
}

int main() {
    char in[256];
    while (fgets(in, 256, stdin)) {
        char *dot = strchr(in, '.');
        if (!dot) continue;
        *dot = '\0';

        char *t = strtok(in, " ");
        int i = 0;
        while (t && i < 4) {
            int op = get_op(t);
            if (op != -1) RAM[i] = (unsigned char)op;
            else RAM[i] = (unsigned char)atoi(t) % 4;
            t = strtok(NULL, " ");
            i++;
        }
        run_asm();
    }
    return 0;
}
