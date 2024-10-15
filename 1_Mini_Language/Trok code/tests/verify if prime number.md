
```
func verify_prime : <nr={|int}>-><bool>
{
	?( nr < 2 ) :
		<<< false;
	?( nr == 2 ) :
		<<< true;
	?( nr % 2 == 0 ) :
		<<< false;
	#] i = {0|int} | i*i>=nr | i=i+2 [:
		?( nr % i == 0) :
			<<< false
	<<< true;
}


func main : <>-><>
{
	nr = {21|int} <<< input;
	output <<< verify_prime();
}
```