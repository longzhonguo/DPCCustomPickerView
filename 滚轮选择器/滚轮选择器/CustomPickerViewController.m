//
//  CustomPickerViewController.m
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "CustomPickerViewController.h"
#import "DPCPickerItemCell.h"

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@interface CustomPickerViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSArray *array;
    DPCPickerItemCell *lastCell;
}
@property (nonatomic, strong) UILabel *selectedLab;
@end

@implementation CustomPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    array = [NSArray arrayWithObjects:@"",@"",@"20200301期",@"20200302期",@"20200303期",@"20200304期",@"20200305期",@"",@"", nil];
    
    UIView *pickerV = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 250)];
    [self.view addSubview:pickerV];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    //    [tableview registerClass:[DPCTableViewCell class] forCellReuseIdentifier:NSStringFromClass([DPCTableViewCell class])];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.bounces = NO;
    
    [pickerV addSubview:tableview];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 50)];
    v.backgroundColor = UIColor.clearColor;
    v.userInteractionEnabled = NO;
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(17, 8, [UIScreen mainScreen].bounds.size.width-17-16, 1)];
    v1.backgroundColor = UIColorFromRGBA(0x1F0F0F0, 1);
    v1.layer.cornerRadius = 0.5;
    v1.clipsToBounds = YES;
    v1.userInteractionEnabled = NO;
    [v addSubview:v1];
    
    UIView *v2 = [[UIView alloc] initWithFrame:CGRectMake(17, 8+43, [UIScreen mainScreen].bounds.size.width-17-16, 1)];
    v2.backgroundColor = UIColorFromRGBA(0x1F0F0F0, 1);
    v2.layer.cornerRadius = 0.5;
    v2.clipsToBounds = YES;
    v2.userInteractionEnabled = NO;
    [v addSubview:v2];
    
    self.selectedLab.text = array[2];
    [v addSubview:self.selectedLab];
    [pickerV addSubview:v];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellditife= @"Cell";
    DPCPickerItemCell * cell = [tableView dequeueReusableCellWithIdentifier:cellditife];
    if (!cell) {
        cell = [[DPCPickerItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellditife];
    }
    if (indexPath.row < array.count) {
        cell.currentLab.text = array[indexPath.row];
    }
    cell.selectionStyle = UITableViewScrollPositionNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.selectedLab.hidden = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.selectedLab.hidden = YES;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate) return;
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView {
    NSIndexPath *topIndexPath = [tableView indexPathForRowAtPoint: CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y+25)];
    [tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    NSLog(@"点前选中的Cell是第%ld个",topIndexPath.row);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.selectedLab.hidden = NO;
        self.selectedLab.text = self->array[topIndexPath.row+2];
    });
}

- (UILabel *)selectedLab{
    if (!_selectedLab) {
        _selectedLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 1+8, [UIScreen mainScreen].bounds.size.width, 42)];
        _selectedLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _selectedLab.textColor = UIColorFromRGBA(0x0CB65B, 1);
        _selectedLab.backgroundColor = UIColor.whiteColor;
        _selectedLab.textAlignment = NSTextAlignmentCenter;
    }
    return _selectedLab;
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
