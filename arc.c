#include <stdio.h>
#include <string.h>
#include <stdlib.h>

unsigned char mem[4] = {0};
unsigned char acc = 0;
unsigned char pc = 0;

void run() {
    pc = 0;
    int limit = 0;
    while (pc < 4 && limit < 20) {
        unsigned char op = mem[pc];
        unsigned char arg = mem[pc + 1];
        if (op == 0) acc = arg;                   // LOAD
        else if (op == 1) acc = (acc + arg) % 4;  // ADD
        else if (op == 2) mem[arg % 4] = acc;     // STR (STORE)
        else if (op == 3) { pc = arg % 4; limit++; continue; } // JMP
        pc += 2;
        limit++;
    }
    printf("%d\n", acc);
}

int get_op(char *s) {
    if (strcmp(s, "LOAD") == 0) return 0;
    if (strcmp(s, "ADD") == 0) return 1;
    if (strcmp(s, "STR") == 0) return 2;
    if (strcmp(s, "JMP") == 0) return 3;
    return 0;
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
            if (i % 2 == 0) mem[i] = get_op(t);
            else mem[i] = atoi(t);
            t = strtok(NULL, " ");
            i++;
        }
        run();
    }
    return 0;
}
