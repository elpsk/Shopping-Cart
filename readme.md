# Shopping Cart

A simple drag 'n drop shopping cart for iOS.

iOS 5.0+. ARC.

![A Screenshot](https://raw.github.com/elpsk/Shopping-Cart/master/A.png "A")
![B Screenshot](https://raw.github.com/elpsk/Shopping-Cart/master/B.png "B")
![C Screenshot](https://raw.github.com/elpsk/Shopping-Cart/master/C.png "A")
![D Screenshot](https://raw.github.com/elpsk/Shopping-Cart/master/D.png "B")

More example on www.albertopasca.it/whiletrue


## How to use


```
	APChartObject appleObject = [[APChartObject alloc] initWithFrame:CGRectMake(0, 0, 80, 80) target:self selector:@selector(panDetected:)];
	appleObject.image		 = [UIImage imageNamed:@"apple"];
	appleObject.text		 = @"apple";
	appleObject.price		 = 1.30;
	appleObject.quantity = 3;

	[ _scrollview addSubview:appleObject.imageView ];   
```

## TODO
Everithing!
You can set quantity, add, remove objects, etc...
Nothing implemented seriously.


## Copyrigth

(c)2012 Alberto Pasca. More info -> albertopasca.it.

## License

Enjoy.
