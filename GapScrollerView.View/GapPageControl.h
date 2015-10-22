//
//  GapPageControl.h
//  GapScrollerView
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Gap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GapPageControl : UIPageControl
/*
 * currentImageName current page control Image
 * indicatorImageName    
*/
- (id)initWithFrame:(CGRect)frame
   currentImageName:(NSString *)currentImageName
 indicatorImageName:(NSString *)indicatorImageName ;

@end
