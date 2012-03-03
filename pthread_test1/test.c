#include "pthread.h"
#include "stdio.h"
#include "pthread.h"
#include "stdlib.h"

void *pthread_test()
{

	while(1)
	{
		printf("i am pthread\n");

	}
}
int main()
{	phread_t pid;
	pthread_create(&pid,NULL,pthread_test,NULL);
	while(1)
	{
	printf("i am main pthread!!!\n");
	
	}
return 0;

}
