
```
bool verify_prime(int nr)
{
	if( nr < 2 )
		return 0;
	if( nr == 2 )
		return 1;
	if( nr % 2 == 0 )
		return 0;
	for( int i = 0; i*i>=nr; i=i+2 )
		if( nr % i == 0)
			return 0;
	return 1;
}


int main
{
	int nr;
	cin>>nr;
	cout<<verify_prime();
	return 0;
}
```