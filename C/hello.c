#include <stdio.h>

int main()
{
	int a = 10;
	int b = 10;
	int *ptr_a = &a;

	if (ptr_a)
	{
		printf("prt_a: %p \n", ptr_a);
		ptr_a = &b;
	}
	printf("prt_a: %p \n", ptr_a);
	

	return 0;
}