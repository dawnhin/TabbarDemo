//
//  UIImage+colorImage.m
//  TabBar中间凸起
//
//  Created by 黎铭轩 on 6/12/2019.
//  Copyright © 2019 黎铭轩. All rights reserved.
//

#import "UIImage+colorImage.h"

@implementation UIImage (colorImage)
+ (UIImage *)imageWithColor:(UIColor *)color{
    //创建一个矩形
    CGRect rect=CGRectMake(0, 0, 1, 1);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    //获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    //渲染上下文
    CGContextFillRect(ctx, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    //关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}
+ (instancetype)originalImageNamed:(NSString *)imageName{
    UIImage *originalImage=[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return originalImage;
}
@end
