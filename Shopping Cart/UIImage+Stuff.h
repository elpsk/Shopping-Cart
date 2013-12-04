//
//  UIImage+Stuff.h
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stuff)

//
// return an UIImage from a CALayer
//
+ ( UIImage* ) grabImage:(CALayer*)layer;

@end
