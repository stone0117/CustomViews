//
//  SNTextView.m
//  SNTextView
//
//  Created by stone on 16/7/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNTextView.h"

#define ExtendAnimateDuration 0.25

@interface SNTextView()<SNTextViewDelegate>

@end
@implementation SNTextView
@dynamic delegate;

NSString * const SNTextViewChangeHeightNotification = @"SNTextViewChangeHeightNotification";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self preSettings];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self preSettings];
    }
    return self;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"111");
}

- (void)preSettings {
    // 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:self];

    if(!_textStartX){
        _textStartX = 5;
    }
    if(!_textStartY){
        _textStartY = 8;
    }
    
    _placeholderLocation = CGPointMake(_textStartX, _textStartY);
    _placeholderColor = [UIColor lightGrayColor];
    _extendDirection = ExtendDirectionDown; // 默认向下伸长
    _isCanExtend = YES; // 默认可以伸长
    _extendLimitRow = 1000; // 默认没有限制
    self.delegate = self;
}
- (void)textChanged {
    [self setNeedsDisplay];

    /** textView改变的时候需要做的事, 用户自定义 */
    if ([self.delegate respondsToSelector:@selector(textView:textDidChanged:)]) {
        [self.delegate textView:self textDidChanged:self.text];
    }
}
- (void)drawRect:(CGRect)rect {
    // 占位文字的位置 x, y
    if ([self.text isEqualToString:@""]) {
        CGFloat width = rect.size.width - 2 * _placeholderLocation.x;
        CGFloat height = rect.size.height - 2 * _placeholderLocation.y;
        NSMutableDictionary * attr = [NSMutableDictionary dictionary];
        attr[NSForegroundColorAttributeName] = _placeholderColor;
        attr[NSFontAttributeName] = self.font;
        [_placeholder drawInRect:CGRectMake(_placeholderLocation.x, _placeholderLocation.y, width, height) withAttributes:attr];
    }
}
- (void)layoutSubviews {

    [super layoutSubviews];

    // 文字行数
    CGRect textFrame = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width - 2 * _textStartX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : self.font } context:nil];
    CGSize textSize = [self.text sizeWithAttributes:@{NSFontAttributeName : self.font}];
    NSUInteger textRow = (NSUInteger)(textFrame.size.height / textSize.height);

    //  限制行数
    if (_extendLimitRow >= textRow) {

        if (self.contentSize.height > self.frame.size.height && self.isCanExtend) { // 伸长

            [self extendFrame:(int)self.tag];

        } else if (self.contentSize.height + 8 < self.frame.size.height && self.isCanExtend) { // 收回

            [self extendFrame:(int)self.tag];
        }
    }
}
- (void)extendFrame:(int)textViewTag {
    if (_extendDirection == ExtendDirectionUp) { // 向上伸长
        CGFloat offset = self.contentSize.height - self.frame.size.height;
        [UIView animateWithDuration:ExtendAnimateDuration animations:^{
          self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - offset, self.frame.size.width, self.contentSize.height);
          if ((int)self.contentSize.height != _lastheight) {
              _lastheight = self.contentSize.height;
              NSNumber * textViewHeight = @(_lastheight);
              NSNumber * row = @(textViewTag);
              [[NSNotificationCenter defaultCenter] postNotificationName:SNTextViewChangeHeightNotification object:@[ textViewHeight, row ]];
          }

        }];
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    } else { // 向下伸长
        [UIView animateWithDuration:ExtendAnimateDuration animations:^{
          self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.contentSize.height);
          NSLog(@"height :%f", self.contentSize.height);
          if ((int)self.contentSize.height != _lastheight) {
              _lastheight = self.contentSize.height;
              NSNumber * textViewHeight = @(_lastheight);
              NSNumber * row = @(textViewTag);
              [[NSNotificationCenter defaultCenter] postNotificationName:SNTextViewChangeHeightNotification object:@[ textViewHeight, row ]];
          }

        }];
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;

    [self setNeedsDisplay];
}
/** 去除holder */
- (void)setText:(NSString *)text {
    [super setText:text];

    [self setNeedsDisplay];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
@end
