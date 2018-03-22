#include <stdio.h>
#include <stdlib.h>

struct node
{
    char year[4];
    unsigned long total;
    unsigned short person;
    unsigned short salary;
}s[21];

struct rec
{
    char year[4];
    char a;
    unsigned long total;
    char b;
    unsigned short person;
    char c;
    unsigned short salary;
    char d;
}t[21];

int main()
{
    long i,j;
    //take year the data of year 1995 as example
    s[0].year[0]='1';
    s[0].year[1]='9';
    s[0].year[2]='9';
    s[0].year[3]='5';
    s[0].total=5937000;
    s[0].person=17800;
    //change to 21
    for (i=0;i<1;i++)
    {
        for (j=0;j<4;j++)
            t[i].year[j]=s[i].year[i];
        t[i].a=' ';
        t[i].total=s[i].total;
        t[i].b=' ';
        t[i].person=s[i].person;
        t[i].c=' ';
        t[i].salary=t[i].total/t[i].person;
        t[i].d=' ';
    }
    return 0;
}
