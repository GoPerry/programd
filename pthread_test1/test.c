#include "pthread.h"
#include "stdio.h"
#include "pthread.h"
#include "stdlib.h"
// qiang zhi lei xing zhuan huan wei void * 
// pthread _test is original pointer 
void *pthread_test()
{
	int i=5;
	while(i--)
	{
		printf("i am pthread\n");

	}
}
int main()
{	pthread_t pid1;
	int err;
	pthread_create(&pid1,NULL,pthread_test,NULL);
	if(err!=0)
		printf("cant not create test pthread!");
	pthread_join(pid1,NULL);
	if(err!=0)
		printf("can not join test pthread !");
	
	
	int x=3;
	while(x--)
	{
	printf("i am main pthread!!!\n");
	
	}
return 0;
//exit(0);

}
