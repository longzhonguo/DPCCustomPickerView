//
//  DPCPickerView.h
//  滚轮选择器
//
//  Created by Jared on 2020/8/21.
//  Copyright © 2020 Jared. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPCPickerView : UIView

@property (nonatomic, assign) BOOL isStop; // 滚动是否停止

@property (nonatomic, copy) void(^selectIndex)(NSInteger index);

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)arr defaultIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
