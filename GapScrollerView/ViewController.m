//
//  ViewController.m
//  GapScrollerView
//
//  Created by Mac on 15/10/21.
//  Copyright © 2015年 Gap. All rights reserved.
//

#import "ViewController.h"
#import "AdvertisingColumn.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AdvertisingColumn *adView = [[AdvertisingColumn alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    //设置广告滚动的图片， 一半情况是网络加载图片，可以在网络请求加载完成后去根据图片设置frame，和设置图片滚动的arr
    [adView setArray:@[@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg"]];
    adView.ADImageClick = ^(UITapGestureRecognizer *sender) {
        [self imageTapAction:sender];
    };
    [self.view addSubview:adView];
}

/**
 *  点击图片响应事件
 *
 *  @param sender 通过sender.view.tag 去获取手势的tag，对手势加以区分
 */
- (void)imageTapAction:(UITapGestureRecognizer *)sender {
    switch (sender.view.tag) {
        case 120:
            [self alertViewWithMsg:@"frist Image clicked"];
            break;
        case 121:
            [self alertViewWithMsg:@"Seconde Image Clicked"];
            break;
        case 123:
            [self alertViewWithMsg:@"thrid Image Clicked"];
            break;
        default:
            break;
    }
}

- (void)alertViewWithMsg:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
