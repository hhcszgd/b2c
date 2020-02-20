//
//  NSString+StrSize.m
//  b2c
//
//  Created by wangyuanfei on 3/29/16.
//  Copyright © 2016 www.16lao.com. All rights reserved.
//

#import "NSString+StrSize.h"

@implementation NSString (StrSize)
- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize {
    NSDictionary *attr = @{NSFontAttributeName : font};
   
    return [self boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
    
}
- (CGSize)stringSizeWithFont:(CGFloat )textFont{
    UIFont * font = [UIFont systemFontOfSize:textFont];
    NSDictionary *attr = @{NSFontAttributeName : font};
   return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}
@end
