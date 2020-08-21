//
//  DPCPickerItemCell.m
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import "DPCPickerItemCell.h"
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

@implementation DPCPickerItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _init];
    }
    return self;
}

-(void)_init{
    [self.contentView addSubview:self.currentLab];
}

- (UILabel *)currentLab{
    if (!_currentLab) {
        _currentLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 48)];
        _currentLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
        _currentLab.textColor = UIColorFromRGBA(0x969696, 1);
        _currentLab.textAlignment = NSTextAlignmentCenter;
    }
    return _currentLab;
}
@end
