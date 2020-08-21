//
//  ViewController.m
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "ViewController.h"
#import "DPCPickerView.h"
#import "DPCChapterQiPickerView.h"

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@interface ViewController ()

@property (nonatomic, strong) DPCPickerView *pickerV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 300)];
//    v.backgroundColor = UIColor.greenColor;
//    [self.view addSubview:v];
//
//    NSArray *arr = @[@"20200301期",@"20200302期",@"20200303期",@"20200304期",@"20200305期"];
//    self.pickerV = [[DPCPickerView alloc] initWithFrame:CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width, 250) titleArray:arr];
//    [v addSubview:self.pickerV];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NSArray *array = @[@"20200301期",@"20200302期",@"20200303期",@"20200304期",@"20200305期",@"20200306期",@"20200307期",@"20200308期"];
    DPCChapterQiPickerView *pickview = [[DPCChapterQiPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) itemArr:array defaultIndex:0];
    pickview.selectIndex = ^(NSInteger index) {
        NSLog(@"======= 选中 %ld",index);
    };
//    [pickview.dataArray addObjectsFromArray:array];
//    pickview.selectedRow = @"2";
//    pickview.back = ^(NSString *date){
//        
//        NSLog(@"日期====%@",date);
//    };
}


@end
