//
//  APViewController.m
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import "APViewController.h"
#import "UIImage+Stuff.h"
#import "APChartObject.h"


@interface APViewController ()
{
	//
	// cart objects
	//
	APChartObject *_appleObj,	*_appleObj2;
	APChartObject *_pearObj,	*_pearObj2;
	APChartObject *_kiwiObj,	*_kiwiObj2;

	//
	// draggable view
	//
	UIImageView *_selectedView;

	//
	// initial position
	//
	CGPoint	_startPoint;
}
@end


@implementation APViewController


- (void)viewDidLoad
{
	[super viewDidLoad];

	[ self performSelector:@selector(initAll) withObject:nil afterDelay:0 ];
}

- (void) initAll
{
	[ self initModel		];
	[ self initScroller ];
		
	_selectedModel = nil;

	[self addObserver:self forKeyPath:@"selectedModel" options:NSKeyValueObservingOptionNew context:@"model"];
}


// +---------------------------------------------------------------------------+
#pragma mark - Observer
// +---------------------------------------------------------------------------+


//
// model observer
//
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ( [keyPath isEqualToString:@"selectedModel"] )
	{
		//		NSLog( @"Description: %@",	  _selectedModel.text		  );
		//		NSLog( @"Price:       %.2f€", _selectedModel.price		);
		NSLog( @"Quantity: %d",	  _selectedModel.quantity );
	}
	else
	{
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}


// +---------------------------------------------------------------------------+
#pragma mark - Model
// +---------------------------------------------------------------------------+


- (void) initModel
{
	//
	// some example objects
	//
	_appleObj = [[APChartObject alloc] initWithFrame:CGRectMake(0, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_appleObj.image		 = [UIImage imageNamed:@"apple"];
	_appleObj.text		 = @"apple";
	_appleObj.price		 = 1.30;
	_appleObj.quantity = 3;

	_pearObj = [[APChartObject alloc] initWithFrame:CGRectMake(80, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_pearObj.image		 = [UIImage imageNamed:@"pear"];
	_pearObj.text			 = @"pear";
	_pearObj.price		 = 0.80;
	_pearObj.quantity	 = 5;

	_kiwiObj = [[APChartObject alloc] initWithFrame:CGRectMake(80+80, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_kiwiObj.image		 = [UIImage imageNamed:@"kiwi"];
	_kiwiObj.text      = @"kiwi";
	_kiwiObj.price		 = 0.75;
	_kiwiObj.quantity	 = 2;

	_appleObj2 = [[APChartObject alloc] initWithFrame:CGRectMake(80+80+80, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_appleObj2.image    = [UIImage imageNamed:@"apple"];
	_appleObj2.text	    = @"apple2";
	_appleObj2.price		= 1.05;
	_appleObj2.quantity = 2;

	_pearObj2 = [[APChartObject alloc] initWithFrame:CGRectMake(80+80+80+80, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_pearObj2.image    = [UIImage imageNamed:@"pear"];
	_pearObj2.text	   = @"pear2";
	_pearObj2.price		 = 0.55;
	_pearObj2.quantity = 4;

	_kiwiObj2 = [[APChartObject alloc] initWithFrame:CGRectMake(80+80+80+80+80, 0, 80, 80) target:self selector:@selector(panDetected:)];
	_kiwiObj2.image		 = [UIImage imageNamed:@"kiwi"];
	_kiwiObj2.text		 = @"kiwi2";
	_kiwiObj.price		 = 1.25;
	_kiwiObj.quantity	 = 7;
}


// +---------------------------------------------------------------------------+
#pragma mark - Scroll view
// +---------------------------------------------------------------------------+


- (void) initScroller
{
	[ _scrollview addSubview:_appleObj.imageView	];
	[ _scrollview addSubview:_pearObj.imageView		];
	[ _scrollview addSubview:_kiwiObj.imageView		];
	[ _scrollview addSubview:_appleObj2.imageView ];
	[ _scrollview addSubview:_pearObj2.imageView	];
	[ _scrollview addSubview:_kiwiObj2.imageView	];

	//
	// prepare scrollview size ( *6 = count of objects )
	//
	_scrollview.contentSize = CGSizeMake (80*6, 80);
}


// +---------------------------------------------------------------------------+
#pragma mark - View exchange
// +---------------------------------------------------------------------------+


//
// make the tricks.
// Add a subview with the screenshot of selected and move around the screen
//
- ( void) cloneViewWithCenter:(CGPoint)point image:(UIImage*)grab
{
	if ( _selectedView ) [ _selectedView removeFromSuperview ];

	_selectedView = [[ UIImageView alloc ] initWithImage:grab ];
	_selectedView.frame = CGRectMake(point.x, point.y, grab.size.width, grab.size.height);
	_selectedView.userInteractionEnabled = YES;

	[ self.view addSubview:_selectedView ];

	UIPanGestureRecognizer *pan = [[ UIPanGestureRecognizer alloc ] initWithTarget:self action:@selector(moveObject:) ];
	[ pan setMinimumNumberOfTouches:1 ];
	[ _selectedView addGestureRecognizer:pan ];
}


// +---------------------------------------------------------------------------+
#pragma mark - Refresh
// +---------------------------------------------------------------------------+


//
// refresh loop
//
- (void) refreshView
{
	[UIView animateWithDuration:0.2 animations:^
	 {
		 CGRect r = _selectedView.frame;

		 switch ( _dragging ) {
			 case tDragStatusBegin:
				 r.size.width  *= 2;
				 r.size.height *= 2;
				 break;
			 case tDragStatusEnd:
				 r.size.width  /= 2;
				 r.size.height /= 2;
				 break;
			 case tDragStatusIntersectIn:
				 r.size.width  = 1;
				 r.size.height = 1;

				 [ self finishDrag ];
				 break;
			 case tDragStatusIntersectOut:
				 _selectedView.center = _startPoint;
				 break;
		 }

		 _selectedView.frame = r;

	 } completion:^(BOOL finished)
	{

		if ( _dragging == tDragStatusIntersectOut )
			_selectedView.hidden = YES;

	 }];
}

//
// end drag
//
- (void) finishDrag
{
	UIImageView *img = [[UIImageView alloc] initWithImage:_selectedView.image];
	[ self appendView:img ];
}

//
// check for insertion in cart (or not)
//
- (void) checkForIntersection
{
	//
	// ABS coords.
	//
	CGRect childRect = [ self.view convertRect:_selectedView.frame fromView:nil ];
	CGRect cartRect  = [ self.view convertRect:_cart.frame				 fromView:nil ];

	if ( CGRectIntersectsRect ( childRect, cartRect ))
	{
		self.dragging = tDragStatusIntersectIn;

		//
		// update quantity
		//
		self.selectedModel.quantity--;
	}
	else
	{
		self.dragging = tDragStatusIntersectOut;
	}
}

- (void) refreshCart
{
	[ _cart setContentOffset:CGPointMake(_cart.contentOffset.x, 0) animated:YES ];
}


// +---------------------------------------------------------------------------+
#pragma mark - Pan gesture
// +---------------------------------------------------------------------------+


- ( void ) panDetected:(UIPanGestureRecognizer*)gesture
{
	self.selectedModel = ((APCartImageView*)gesture.view).data;

	//
	// lock pan if quantity == 0.
	//
	if ( !self.selectedModel.valid )
		return;


	CGPoint pInView = [ gesture locationInView:self.view ];
	CGSize  pSize   = gesture.view.frame.size;

	if ( gesture.state == UIGestureRecognizerStateBegan )
	{
		_startPoint = pInView;

		//
		// grab image
		//
		UIImage *grab = [ UIImage grabImage: gesture.view.layer ];

		//
		// centering view
		//
		pInView.x = pInView.x - pSize.width/2;
		pInView.y = pInView.y - pSize.height/2;

		[ self cloneViewWithCenter:pInView image:grab ];

		self.dragging = tDragStatusBegin;
	}
	else if ( gesture.state == UIGestureRecognizerStateChanged )
	{
		[ self moveObject:gesture ];
	}
	else if ( gesture.state == UIGestureRecognizerStateEnded )
	{
		self.dragging = tDragStatusEnd;
		[ self checkForIntersection ];
	}
}

//
// move draggable view around
//
- (void) moveObject:(UIPanGestureRecognizer *)pan
{
  _selectedView.center = [ pan locationInView:_selectedView.superview ];
}


// +---------------------------------------------------------------------------+
#pragma mark - Setter
// +---------------------------------------------------------------------------+


- (void)setDragging:(tDragStatus)dragging
{
	_dragging = dragging;
	[ self refreshView ];
}


// +---------------------------------------------------------------------------+
#pragma mark - Chart view
// +---------------------------------------------------------------------------+


//
// recursively append view to scrollview.
// If position already contains a view, shift and retry.
//
- (void) appendView:(id)view
{
	UIView *v = view;
	
	CGRect vRect = [ self.view convertRect:v.frame fromView:nil ];
	
	for ( UIView *innerView in _cart.subviews )
	{
		CGRect cartRect = [ self.view convertRect:innerView.frame fromView:nil ];
		
		if ( CGRectIntersectsRect(vRect, cartRect) )
		{
			CGRect r = v.frame;
			r.origin.x += r.size.width;
			v.frame = r;
			
			_cart.contentSize = CGSizeMake(r.origin.x + 80, 80);
			
			return [ self appendView:v ];
		}
	}

	[ _cart addSubview:view ];

	[ self performSelector:@selector(refreshCart) withObject:nil afterDelay:0 ];
}


@end


