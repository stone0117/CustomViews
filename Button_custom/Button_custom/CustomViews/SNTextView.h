//
//  SNTextView.h
//  SNTextView
//
//  Created by stone on 16/7/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNTextView;

typedef NS_ENUM(NSUInteger, ExtendDirection) {
    ExtendDirectionUp,
    ExtendDirectionDown
};

UIKIT_EXTERN NSString * const SNTextViewChangeHeightNotification;

@protocol SNTextViewDelegate <NSObject, UITextViewDelegate>

@optional
// 监听输入框内的文字变化
- (void)textView:(SNTextView *)TextView textDidChanged:(NSString *)text;
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
@end

@interface SNTextView : UITextView
//#define TextStartX 5
//#define TextStartY 8
/** textStartX = 默认5 */
@property(nonatomic, assign) CGFloat textStartX;
/** textStartY = 默认8*/
@property(nonatomic, assign) CGFloat textStartY;
/** 占位文字 */
@property(nonatomic, copy) NSString * placeholder;
/** 占位文字颜色 */
@property(nonatomic, strong) UIColor * placeholderColor;
/** 占位文字的起始位置 */
@property(nonatomic, assign) CGPoint placeholderLocation;
/** textView是否可伸长 */
@property(nonatomic, assign) BOOL isCanExtend;
/** 伸长方向 */
@property(nonatomic, assign) ExtendDirection extendDirection;
/** 伸长限制行数 */
@property(nonatomic, assign) NSUInteger extendLimitRow;
//记录每一次的的frame的高度
@property(nonatomic, assign) int lastheight;

@property(nonatomic, weak) id<SNTextViewDelegate> delegate;
@end

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//
//    self.textView = [[SNTextView alloc] initWithFrame:CGRectMake(20, 250, [UIScreen mainScreen].bounds.size.width - 16, 50)];
//    _textView.textColor = [UIColor blackColor];
//    _textView.font = [UIFont systemFontOfSize:14];
//    _textView.placeholder = @"请再次输入您的信息";
//    _textView.isCanExtend = YES;
//    _textView.extendLimitRow = 10;
//    /** 伸缩方向 */
//    _textView.extendDirection = ExtendDirectionUp;
//    _textView.backgroundColor = [UIColor clearColor];
//    _textView.layer.borderWidth = 1;
//    [self.view addSubview:_textView];
//}

//TODO: 加载cell上没事 , 加在 sectionView上 容易崩...郁闷...