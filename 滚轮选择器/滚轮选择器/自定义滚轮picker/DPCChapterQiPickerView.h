//
//  DPCChapterQiPickerView.h
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPCChapterQiPickerView : UIView

@property (nonatomic, copy) void(^selectIndex)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame itemArr:(NSArray *)itemArr defaultIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
