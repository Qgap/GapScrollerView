//
//  AdvertisingColumn.h
//  Meihuishuo
//
//  Created by Mac on 15/8/10.
//  Copyright (c) 2015年 Gap. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ADImageClick)(UITapGestureRecognizer *);

@interface AdvertisingColumn : UIView

- (void)setArray:(NSArray *)imgArray;

//@property (nonatomic, copy) ADImageClick sendTap;

@property (nonatomic, copy) void(^ADImageClick)(UITapGestureRecognizer *);

@end
