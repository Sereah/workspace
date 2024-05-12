#include<stdio.h>

int main()
{
	double array[] = {2,4,6,8,100};
	printf("array: %p \n", array);
	printf("array: %p \n", &array[0]);
	return 0;
}	