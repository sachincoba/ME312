#include<bits/stdc++.h>
using namespace std;
int main()
{
	long long  int t;
	cin >>t;
	while(t--)
	{
		long long  int n;
		cin>>n;
		string s ;
		char x;
		cin >>s>>x;
		long long  int p,sum=0,i=0,h=0,m=0;
		for (i = 0; i < n; ++i)
		{
			if(s[i]== x)
			{
				h=1;
				sum+=((i)*(i+1))/2;
				break;
			}
		}
		p=i;
		for (long long  int j = i+1; j < n; ++j)
		{
			m++;
			if(s[j]== x)
			{
				p=j-p;
				sum+=((p-1)*(p))/2;
				p=j;
				m=0;
			}
		}
		//cout<<m<<endl;
		if(h==0)
		{
			cout <<"0"<<endl;
		}
		else
		{
			cout <<((n)*(n+1))/2  - sum - ((m)*(m+1))/2 << endl;
		}
		
	}
} 