//
//  APViewController.h
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APChartObject;


//
// drag status
//
typedef enum {
	tDragStatusBegin = 0,
	tDragStatusEnd,
	tDragStatusIntersectIn,
	tDragStatusIntersectOut
} tDragStatus;


@interface APViewController : UIViewController

//
// scrollview with products
//
@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
//
// scrollview cart
//
@property (nonatomic, strong) IBOutlet UIScrollView *cart;

@property (nonatomic, assign) tDragStatus dragging;

@property (nonatomic, strong) APChartObject *selectedModel;

@end
