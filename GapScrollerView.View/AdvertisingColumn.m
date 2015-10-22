//
//  AdvertisingColumn.m
//  Meihuishuo
//
//  Created by Mac on 15/8/10.
//  Copyright (c) 2015年 Gap. All rights reserved.
//

#import "AdvertisingColumn.h"
#import "GapPageControl.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface AdvertisingColumn ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView          *adScroller;
@property (nonatomic, strong) NSTimer               *timer;
@property (nonatomic, strong) GapPageControl        *pageControl ;
@property (nonatomic, strong) NSMutableArray        *imageArr;
@property (nonatomic, assign) float                 scrollerHeight;

@end

@implementation AdvertisingColumn

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.adScroller = [self createScrollViewWithFrame:frame contentSize:CGSizeZero showVer:NO showHor:NO delegate:self IStranslatesAutoresizingMask:NO];
        self.scrollerHeight = frame.size.height;
        [self addSubview:self.adScroller];
        self.imageArr = [NSMutableArray array];
    
    }
    return self;
}

- (void)setArray:(NSArray *)imgArray {
    NSInteger count = imgArray.count;
    [self.imageArr addObjectsFromArray:imgArray];
    self.adScroller.delegate = self;
    if (count >1) {
        self.adScroller.contentSize = CGSizeMake(SCREEN_WIDTH * (count+2) , self.scrollerHeight);
    }else {
        self.adScroller.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollerHeight);
    }
    if (count == 0) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollerHeight)];
        [self.adScroller addSubview:imageView];
    }else {
        for (int i = 0; i < count; i ++) {
            UIImageView *image = [[UIImageView alloc] init];
            if (count >1) {
                image.frame = CGRectMake(SCREEN_WIDTH *(i+1), 0, SCREEN_WIDTH, self.scrollerHeight);
            }else{
                image.frame = CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, self.scrollerHeight);
            }
            image.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)];
            [tap setNumberOfTapsRequired:1];
            [image addGestureRecognizer:tap];
            tap.view.tag = 120 +i;
//            [image sd_setImageWithURL:[NSURL URLWithString:imgArray[i]]];
            image.image = [UIImage imageNamed:imgArray[i]];
            [self.adScroller addSubview:image];

        }
        
        if (count >1) {
            self.pageControl = [[GapPageControl alloc] initWithFrame:CGRectMake(0, self.scrollerHeight - 30, SCREEN_WIDTH, 20) currentImageName:@"currentPage_icon" indicatorImageName:@"pageIndicator_icon"];

        
            self.pageControl.numberOfPages = count;
            self.pageControl.currentPage = 0;
            self.pageControl.hidesForSinglePage = YES;
            self.pageControl.userInteractionEnabled = NO;
    
            [self addSubview:self.pageControl];
            [self bringSubviewToFront:self.pageControl];
            
            UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*(imgArray.count+1), 0, SCREEN_WIDTH, self.scrollerHeight)];
//            [lastImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr[0]]];
            lastImageView.image = [UIImage imageNamed:self.imageArr[0]];
            [self.adScroller addSubview:lastImageView];
            
            UIImageView *fristImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollerHeight)];
//            [fristImageView sd_setImageWithURL:[NSURL URLWithString:self.imageArr.lastObject]];
            fristImageView.image = [UIImage imageNamed:self.imageArr.lastObject];
            [self.adScroller addSubview:fristImageView];
            
            [self.adScroller scrollRectToVisible:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:NO];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        }
    }
    self.adScroller.scrollsToTop = NO;
}

#pragma mark - NSTimer Action
- (void)nextPage{
    CGFloat pageWidth = SCREEN_WIDTH;
    int currentPage = self.adScroller.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.imageArr.count-1;
    }
    else if (currentPage == self.imageArr.count+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.adScroller.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    [self.adScroller scrollRectToVisible:rect animated:YES];
    currPageNumber++;
    if (currPageNumber == self.imageArr.count) {
        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.adScroller scrollRectToVisible:newRect animated:YES];
        currPageNumber = 0;        
    }
    self.pageControl.currentPage = currPageNumber;
}

#pragma mark - UIImage TapGestureRecognizer
- (void)imageClick:(UITapGestureRecognizer *)sender
{
//    if (self.sendTap) {
//        self.sendTap(sender);
//    }
    if (self.ADImageClick) {
        self.ADImageClick(sender);
    }
}

#pragma mark - UIScrollView delegate methods

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //开始拖动scrollview的时候 停止计时器控制的跳转
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH;
    CGFloat heigth = SCREEN_HEIGHT;
    //当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    int currentPage = self.adScroller.contentOffset.x/width;
    if (currentPage == 0) {
        [self.adScroller scrollRectToVisible:CGRectMake(width*self.imageArr.count, 0, width, heigth) animated:NO];
        self.pageControl.currentPage =self.imageArr.count-1;
    }
    else if (currentPage == self.imageArr.count +1) {
        [self.adScroller scrollRectToVisible:CGRectMake(width, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    //拖动完毕的时候 重新开始计时器控制跳转
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

- (UIScrollView *)createScrollViewWithFrame:(CGRect)frame
                                contentSize:(CGSize)contentSize
                                    showVer:(BOOL)showVer
                                    showHor:(BOOL)showHor
                                   delegate:(id)Target
               IStranslatesAutoresizingMask:(BOOL)ISmask
{
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    scroll.contentSize = contentSize;
    scroll.showsHorizontalScrollIndicator = showHor;
    scroll.showsVerticalScrollIndicator = showVer;
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.translatesAutoresizingMaskIntoConstraints = ISmask;
    scroll.delegate = Target;
    return scroll;
}

@end
