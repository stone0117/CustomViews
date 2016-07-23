//
//  SNButton.h
//  Button_custom
//
//  Created by stone on 16/7/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HexRGBA(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:al]

@interface SNButton : UIButton

@property (nonatomic,copy) void(^actionBlock)(SNButton * button);

- (instancetype)initWithFrame:(CGRect)frame actionBlock:(void(^)(SNButton * button))actionBlock;
/** actionBlock */

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title color:(UIColor *)color;

/** base method */
- (instancetype)initWithFrame:(CGRect)frame titleForNormal:(NSString *)titleForNormal titleForHighlighted:(NSString *)titleForHighlighted titleForDisabled:(NSString *)titleForDisabled titleColorForNomal:(UIColor *)titleColorForNormal titleColorForHighlighted:(UIColor *)titleColorForHighlighted titleColorForDisabled:(UIColor *)titleColorForDisabled colorForNormal:(UIColor *)colorForNormal colorForHighlighted:(UIColor *)colorForHighlighted colorForDisabled:(UIColor *)colorForDisabled actionBlock:(void (^)(SNButton *))actionBlock;
@end
