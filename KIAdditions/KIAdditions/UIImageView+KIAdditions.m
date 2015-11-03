//
//  UIImageView+KIImageView.m
//  Kitalker
//
//  Created by 杨 烽 on 12-8-4.
//
//

#import "UIImageView+KIAdditions.h"

@implementation UIImageView (KIAdditions)

+ (CGSize)sizeToFit:(KIImageFitType)fitType withValue:(CGFloat)value withImage:(UIImage *)image {
    if (image == nil || ![image isKindOfClass:[UIImage class]]) {
        return CGSizeZero;
    }
    
    CGSize imageSize = image.size;
    
    return [UIImageView sizeToFit:fitType withValue:value withImageSize:imageSize];
}

+ (CGSize)sizeToFit:(KIImageFitType)fitType withValue:(CGFloat)value withImageSize:(CGSize)imageSize {
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    //如果图片的宽和高相等，并且小于设定的最大值，则直接返回图片的尺寸
    if (width == height && width <= value) {
        return CGSizeMake(width, height);
    }
    
    CGFloat zoom = 1;
    
    if (fitType == KIImageFitWidth) {
        //如果是根据宽度进行缩放
        
        if (width <= value) {
            //如果宽度小于设定的最大值，则返回图片宽度，高度为实际高度和宽度*2的最小值
            return CGSizeMake(width, MIN(height, width*2));
        }
        zoom = width / value;
        width = value;
        
        if (imageSize.height / imageSize.width > 2) {
            //如果图片的高度是图片宽度的两倍
            height = MAX(MIN(height / zoom, width), 50);
        } else {
            height = MAX(height / zoom, 50);
        }
    } else if (fitType == KIImageFitHeight) {
        if (height <= value) {
            return CGSizeMake(MIN(width, height*2), height);
        }
        zoom = height / value;
        height = value;
        
        if (imageSize.width / imageSize.height > 2) {
            width = MAX(MIN(width / zoom, height*1.5), 50);
        } else {
            width = MAX(width / zoom, 50);
        }
    }
    
    CGSize size = CGSizeMake(width, height);
    return size;
}

- (void)setImage:(UIImage *)image fitType:(KIImageFitType)fitType withValue:(CGFloat)value {
    [self setImage:image];
    [self setContentMode:UIViewContentModeScaleAspectFill];
    
    CGRect newFrame = self.frame;
    newFrame.size = [UIImageView sizeToFit:fitType withValue:value withImage:image];
    [self setFrame:newFrame];
}

@end
