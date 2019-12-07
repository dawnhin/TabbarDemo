//
//  UIImage+colorImage.h
//  TabBar中间凸起
//
//  Created by 黎铭轩 on 6/12/2019.
//  Copyright © 2019 黎铭轩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (colorImage)
/**
 *  根据颜色生成一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (instancetype)originalImageNamed:(NSString *)imageName;
@end

NS_ASSUME_NONNULL_END
