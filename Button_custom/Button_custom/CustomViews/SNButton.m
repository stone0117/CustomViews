//
//  SNButton.m
//  Button_custom
//
//  Created by stone on 16/7/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "SNButton.h"

@interface SNButton ()

@end
@implementation SNButton

- (instancetype)initWithFrame:(CGRect)frame actionBlock:(void (^)(SNButton *))actionBlock {

    return [self initWithFrame:frame titleForNormal:@"button" titleForHighlighted:@"button" titleForDisabled:@"button" titleColorForNomal:[UIColor blackColor] titleColorForHighlighted:[UIColor blackColor] titleColorForDisabled:[UIColor blackColor] colorForNormal:[UIColor colorWithRed:247 / 255.0 green:206 / 255.0 blue:166 / 255.0 alpha:1.0] colorForHighlighted:[UIColor colorWithRed:242 / 255.0 green:154 / 255.0 blue:76 / 255.0 alpha:1.0] colorForDisabled:HexRGBA(0xf1f3f2, 1.0) actionBlock:actionBlock];
}
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color {
    return [self initWithFrame:frame titleForNormal:title titleForHighlighted:title titleForDisabled:title titleColorForNomal:[UIColor blackColor] titleColorForHighlighted:[UIColor blackColor] titleColorForDisabled:[UIColor blackColor] colorForNormal:color colorForHighlighted:color colorForDisabled:color actionBlock:^(SNButton * sender) {

      NSLog(@"%p %@", self, @"btnClicked");

    }];
}

- (instancetype)initWithFrame:(CGRect)frame titleForNormal:(NSString *)titleForNormal titleForHighlighted:(NSString *)titleForHighlighted titleForDisabled:(NSString *)titleForDisabled titleColorForNomal:(UIColor *)titleColorForNormal titleColorForHighlighted:(UIColor *)titleColorForHighlighted titleColorForDisabled:(UIColor *)titleColorForDisabled colorForNormal:(UIColor *)colorForNormal colorForHighlighted:(UIColor *)colorForHighlighted colorForDisabled:(UIColor *)colorForDisabled actionBlock:(void (^)(SNButton *))actionBlock {
    self = [super initWithFrame:frame];
    if (self) {
        if (titleForNormal) {
            [self setTitle:titleForNormal forState:UIControlStateNormal];
        }
        if (titleForHighlighted) {
            [self setTitle:titleForHighlighted forState:UIControlStateHighlighted];
        }
        if (titleForDisabled) {
            [self setTitle:titleForDisabled forState:UIControlStateDisabled];
        }

        if (titleColorForNormal) {
            [self setTitleColor:titleColorForNormal forState:UIControlStateNormal];
        }
        if (titleColorForHighlighted) {
            [self setTitleColor:titleColorForHighlighted forState:UIControlStateHighlighted];
        }
        if (titleColorForDisabled) {
            [self setTitleColor:titleColorForDisabled forState:UIControlStateDisabled];
        }

        if (colorForNormal) {
            UIImage * normal = [self imageWithColor:colorForNormal];
            [self setBackgroundImage:normal forState:UIControlStateNormal];
        }
        if (colorForNormal) {

            UIImage * highlight = [self imageWithColor:colorForHighlighted];
            [self setBackgroundImage:highlight forState:UIControlStateNormal];
        }
        if (colorForNormal) {

            UIImage * disable = [self imageWithColor:colorForDisabled];
            [self setBackgroundImage:disable forState:UIControlStateNormal];
        }

        _actionBlock = actionBlock;
        !actionBlock ?: actionBlock(self);
    }
    return self;
}

- (void)setActionBlock:(void (^)(SNButton *))actionBlock {
    _actionBlock = actionBlock;
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClicked:(SNButton *)sender {
    _actionBlock(sender);
}

//========= convenience method ============================ stone 🐳 ===========/
/** 16进制(字符串形式) 返回 图片 */
- (UIImage *)imageWithString:(NSString *)string {

    return [self imageWithColor:[self colorWithString:string]];
}
/** 16进制返回颜色 */
- (UIColor *)colorWithString:(NSString *)string {
    CGFloat alpha = 1.0f;
    NSNumber * red = @0.0;
    NSNumber * green = @0.0;
    NSNumber * blue = @0.0;

    NSMutableArray<NSNumber *> * colors = [NSMutableArray arrayWithArray:@[ red, green, blue ]];

    unsigned hexComponent;
    NSString * colorString = [string uppercaseString];
    NSLog(@"%ld", colors.count);
    for (int i = 0; i < colors.count; i++) {
        NSString * substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];

        [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];

        NSNumber * temp = colors[i];
        temp = @(hexComponent / 255.0);
        colors[i] = temp;
    }

    return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
}
/** 颜色 返回 图片 */
- (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
