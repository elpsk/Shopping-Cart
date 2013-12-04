//
//  UIImage+Stuff.m
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import "UIImage+Stuff.h"

@implementation UIImage (Stuff)

+ ( UIImage* ) grabImage:(CALayer*)layer
{
	UIGraphicsBeginImageContext ( layer.frame.size );
	[ layer renderInContext:UIGraphicsGetCurrentContext() ];
	
	UIImage *grab = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return grab;
}

@end
