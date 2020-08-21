//
//  PickerViewController.m
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    UIPickerView *myPickerView;
    NSArray *pickerArray;
    UILabel *selectedLab;
    NSInteger selectRow;
}

@end

@implementation PickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addPickerView];
    [self addLabel];
}

- (void)addLabel{
    selectedLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 414, 90)];
    NSInteger i = [myPickerView selectedRowInComponent:0]; // 当前选中第几行
    selectedLab.text = pickerArray[i]; // 当前选中第几行
    [self.view addSubview:selectedLab];
}

- (void)addPickerView {
    pickerArray = [[NSArray alloc] initWithObjects:@"20200400期",
                                                   @"20200401期",
                                                   @"20200402期",
                                                   @"20200403期",
                                                   @"20200404期",
                                                   nil];
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(17, 64, 414-33, 200)];
    myPickerView.backgroundColor = UIColor.greenColor;
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    [self.view addSubview:myPickerView];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - myPickerView.frame.size.height - 50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleDefault];
    NSArray *toolbarItems = [NSArray arrayWithObjects: doneButton, nil];
    [toolBar setItems:toolbarItems];
    
    [myPickerView selectRow:2 inComponent:0 animated:YES];
    
}

#pragma mark - Text field delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        //        [self dateChanged:nil];
    }
}
#pragma mark - Picker View Data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerArray count];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 75;
}

#pragma mark - Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedLab.text = pickerArray[row];
    
    selectRow = row;
    [myPickerView reloadComponent:component];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = UIColor.redColor;
            CGRect rect = singleLine.frame;
            rect.origin.x = 17;
            rect.size.width = singleLine.frame.size.width-17-16;
            rect.size.height = 1;
            singleLine.frame = rect;
            singleLine.layer.cornerRadius = singleLine.frame.size.height/2;
        }
    }
    
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        [pickerLabel setBackgroundColor:[UIColor lightGrayColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    
    if (row == selectRow){
        pickerLabel.font = [UIFont boldSystemFontOfSize:20];
        pickerLabel.textColor = UIColor.blueColor;
    } else {
        pickerLabel.font = [UIFont systemFontOfSize:19];
        pickerLabel.textColor = UIColor.grayColor;
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    return pickerLabel;
}




@end
