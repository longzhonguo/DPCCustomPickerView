//
//  DPCChapterQiPickerView.m
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "DPCChapterQiPickerView.h"
#import "DPCPickerView.h"

#define WS(weakSelf)                      __weak __typeof(&*self)weakSelf = self;
#define KWindowWidth   [UIScreen mainScreen].bounds.size.width
#define KWindowHeight   [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

static NSInteger currentIndex;

@interface DPCChapterQiPickerView() {
    UIButton *backView;
    DPCPickerView *pickview;
    NSArray *dataArr;
}

@end

@implementation DPCChapterQiPickerView

- (instancetype)initWithFrame:(CGRect)frame itemArr:(NSArray *)itemArr defaultIndex:(NSInteger)index {
    if (!itemArr.count) {
        return self;
    }
    self = [super initWithFrame:frame];
    if (self) {
        dataArr = itemArr;
        currentIndex = index;
        [self setUI];
    }
    
    return self;
}

-(void)setUI{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    backView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    backView.backgroundColor = UIColorFromRGBA(0x000000, 0.4);
    [backView addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:backView];
    
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-359, [UIScreen mainScreen].bounds.size.width, 359);
    self.backgroundColor = UIColor.whiteColor;
    // 左上角和右上角 圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.alpha = 1.0;
    [backView addSubview:self];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, 57)];
    topView.backgroundColor = UIColor.whiteColor;
    [self addSubview:topView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 170, 25)];
    title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    title.textColor = UIColorFromRGBA(0x18252C, 1);
    title.text = @"选择你想观看的期次";
    [topView addSubview: title];
    
    UIButton *buttonCancle = [[UIButton alloc]initWithFrame:CGRectMake(KWindowWidth-28-16, 19, 30, 20)];
    [buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
    buttonCancle.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonCancle setTitleColor:UIColorFromRGBA(0x969696, 1) forState:UIControlStateNormal];
    [buttonCancle addTarget:self action:@selector(clickcancle) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview: buttonCancle];

    pickview = [[DPCPickerView alloc] initWithFrame:CGRectMake(0, 57, self.frame.size.width, self.frame.size.height-57-44-10-10) titleArray:dataArr defaultIndex:currentIndex];
    pickview.backgroundColor = [UIColor yellowColor];
    pickview.selectIndex = ^(NSInteger index) {
        currentIndex = index;
    };
    [self addSubview:pickview];
    
    UIButton *buttonSure = [[UIButton alloc]initWithFrame:CGRectMake(21, self.frame.size.height-44-10, self.frame.size.width-21-20, 44)];
    buttonSure.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    [buttonSure setTitleColor:UIColorFromRGBA(0xFFFFFF, 1) forState:UIControlStateNormal];
    [buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [buttonSure setBackgroundImage:[UIImage imageNamed:@"期数选择器确定按钮"] forState:UIControlStateNormal];
    buttonSure.backgroundColor = UIColor.clearColor;
    [buttonSure addTarget:self action:@selector(clicksure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: buttonSure];
}

#pragma mark 取消的的方法
-(void)clickcancle{
    [backView removeFromSuperview];
}

#pragma mark  确定的方法
-(void)clicksure{
    
    if (!pickview.isStop) {
        NSLog(@"还未停止！！！");
        return;
    }
    if (self.selectIndex) {
        self.selectIndex(currentIndex);
    }
    
    [backView removeFromSuperview];
}

@end
