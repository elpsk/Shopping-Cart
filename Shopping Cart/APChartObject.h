//
//  APChartModel.h
//  Shopping Cart
//
//  Created by Alberto Pasca on 03/12/13.
//  Copyright (c) 2013 albertopasca.it. All rights reserved.
//

#import <Foundation/Foundation.h>


@class APChartObject;


//
// The imageview subclass with model
//
@interface APCartImageView : UIImageView
@property (nonatomic, strong) APChartObject *data;
@end


//
// The chart object
//
@interface APChartObject : UIView

//
// some stuffs
//
@property (nonatomic, strong)   NSString				*productId;
@property (nonatomic, strong)   NSString				*text;
@property (nonatomic, assign)   float						price;
@property (nonatomic, assign)   int							quantity;

@property (nonatomic, assign)		BOOL						valid;

@property (nonatomic, strong)   UIImage					*image;
@property (nonatomic, readonly) APCartImageView *imageView;

- (id) initWithFrame:(CGRect)frame target:(id)target selector:(SEL)sel;

@end
