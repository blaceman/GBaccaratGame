//
//  UIView+QuickCreate.m
//  FGClassDemo
//
//  Created by Eric on 17/2/10.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//

#import "UIView+QuickCreate.h"

@implementation UIView (QuickCreate)

- (void)qc_cornerRadius:(CGFloat)corner
{
    self.layer.cornerRadius = corner;
    self.layer.masksToBounds = YES;
}

@end

@implementation UILabel (QuickCreate)

+ (UILabel *)qc_text:(NSString *)text fontSize:(NSInteger)fontSize colorHex:(NSInteger)colorHex
{
    UILabel *label = [UILabel new];
    [label qc_text:text textAlignment:0 font:AdaptedFontSize(fontSize) color:UIColorFromHex(colorHex)];
    return  label;
}

- (void)qc_text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor *)color
{
    if (text) { self.text = text;}
    if (font) {self.font = font;}
    if (color) {self.textColor = color;}
    if (textAlignment) {self.textAlignment = textAlignment;}
}

@end



@implementation UIButton (QuickCreate)

+ (UIButton *)qc_title:(NSString *)title fontSize:(NSInteger)fontSize titleColorHex:(NSInteger)titleColorHex
{
    UIButton *button = [UIButton new];
    [button qc_title:title font:AdaptedFontSize(fontSize) titleColor:UIColorFromHex(titleColorHex)];
    return button;
}

+ (UIButton *)qc_imageString:(NSString *)imageString imageStringSelected:(NSString *)imageStringSelected
{
    UIButton *button = [UIButton new];
    [button qc_image:[UIImage imageNamed:imageString] imageSelected:[UIImage imageNamed:imageStringSelected]];
    return button;
}

- (void)qc_image:(UIImage *)image imageSelected:(UIImage *)imageSelected
{
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
    }
    
    if (imageSelected) {
        [self setImage:imageSelected forState:UIControlStateSelected];
    }
}

- (void)qc_title:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor
{
    if (font) {self.titleLabel.font = font;}
    
    if (title) {
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    if (titleColor) {
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
}
@end

@implementation UIImageView (QuickCreate)

+ (UIImageView *)qc_imageString:(NSString *)imageString
{
    UIImageView *imageView = [UIImageView new];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (!IsEmpty(imageView)) {
        imageView.image = [UIImage imageNamed:imageString];
    }
    
    return imageView;
}

@end
