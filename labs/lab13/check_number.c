#include <stdio.h>
#include <stdlib.h>

int main() {
    int number;
    
    printf("Введите число: ");
    scanf("%d", &number);
    
    if (number > 0) {
        printf("Число положительное\n");
        exit(1); // Код завершения для положительного числа
    } else if (number < 0) {
        printf("Число отрицательное\n");
        exit(2); // Код завершения для отрицательного числа
    } else {
        printf("Число равно нулю\n");
        exit(0); // Код завершения для нуля
    }
}
