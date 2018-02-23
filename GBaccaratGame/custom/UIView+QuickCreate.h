//
//  UIView+QuickCreate.h
//  FGClassDemo
//
//  Created by Eric on 17/2/10.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QuickCreate)

- (void)qc_cornerRadius:(CGFloat)corner;

@end


@interface UILabel (QuickCreate)

#pragma mark - +

/**
 快速创建label
 
 @param text text
 @param fontSize 字体大小
 @param colorHex 颜色编码 16进制
 @return label
 */
+ (UILabel *)qc_text:(NSString *)text fontSize:(NSInteger)fontSize colorHex:(NSInteger)colorHex;

#pragma mark - -

/**
 快速创建label
 
 @param text text
 @param textAlignment textAlignment
 @param font font
 @param color color
 */
- (void)qc_text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor *)color;

@end


@interface UIButton (QuickCreate)

#pragma mark - +

/**
 快速创建 Button
 
 @param title title
 @param fontSize 字体大小
 @param titleColorHex 颜色编码 16进制
 @return button
 */
+ (UIButton *)qc_title:(NSString *)title fontSize:(NSInteger)fontSize titleColorHex:(NSInteger)titleColorHex;

/**
 快速创建 Button
 
 @param imageString image
 @param imageStringSelected 选择状态 image
 @return button
 */
+ (UIButton *)qc_imageString:(NSString *)imageString imageStringSelected:(NSString *)imageStringSelected;

#pragma mark - -

/**
 设置
 
 @param title title
 @param font font
 @param titleColor titleColor
 */
- (void)qc_title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor;

@end

@interface UIImageView (QuickCreate)

/**
 快速创建 imageView
 */
+ (UIImageView *)qc_imageString:(NSString *)imageString;

@end
