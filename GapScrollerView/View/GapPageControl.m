//
//  GapPageControl.m
//  GapScrollerView
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Gap. All rights reserved.
//

#import "GapPageControl.h"

@interface GapPageControl ()
@property (nonatomic, strong)UIImage *currentImage;
@property (nonatomic, strong)UIImage *inactiveImage;
@end

@implementation GapPageControl

- (id)initWithFrame:(CGRect)frame
   currentImageName:(NSString *)currentImageName
 indicatorImageName:(NSString *)indicatorImageName {
    self = [super initWithFrame:frame];
    if (self) {
        self.currentImage = [UIImage imageNamed:currentImageName];
        self.inactiveImage = [UIImage imageNamed:indicatorImageName];
    }
    return self;
}

//图片切换时，改变pagecontrol 的图片
- (void)updateDots {
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView * dot = [self imageViewForSubview:  [self.subviews objectAtIndex: i]];
        if (i == self.currentPage) dot.image = self.currentImage;
        else dot.image = self.inactiveImage;
    }
}

- (UIImageView *)imageViewForSubview:(UIView *) view {
    UIImageView * dot = nil;
    if ([view isKindOfClass: [UIView class]]) {
        for (UIView* subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *) view;
    }
    
    return dot;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self updateDots];
}



@end
