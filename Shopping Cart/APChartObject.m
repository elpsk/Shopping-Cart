//
//  APChartModel.m
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import "APChartObject.h"


@implementation APCartImageView

@end


@interface APChartObject ()
{
	SEL _selector;
	id  _target;
	
	CGRect _frame;
}
@end


@implementation APChartObject


// +---------------------------------------------------------------------------+
#pragma mark - Initialization
// +---------------------------------------------------------------------------+


- (id) initWithFrame:(CGRect)frame target:(id)target selector:(SEL)sel
{
	self = [super init];
	if (self)
	{
		_frame     = frame;
		_target    = target;
		_selector  = sel;

		_text      = @"";
		_productId = @"";
	}

	return self;
}


// +---------------------------------------------------------------------------+
#pragma mark - Image
// +---------------------------------------------------------------------------+


- (void)setImage:(UIImage *)image
{
	_image = image;
}

//
// make an UIImageView adding pan gesture and model
//
- (APCartImageView *)imageView
{
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:_target action:_selector];
	pan.minimumNumberOfTouches = 1;
	
	APCartImageView *imgv = [[APCartImageView alloc] initWithImage:_image];
	imgv.frame = _frame;
	imgv.userInteractionEnabled = YES;
	
	imgv.data = self;
	
	[ imgv addGestureRecognizer:pan ];
	
	return imgv;
}

//
// update objecti quantity. If 0, disable it (or what you want).
//
- (void)setQuantity:(int)quantity
{
	_quantity = quantity;
	_valid = _quantity != 0;
}

@end



