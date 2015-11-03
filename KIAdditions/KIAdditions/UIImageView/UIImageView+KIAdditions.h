//
//  UIImageView+KIImageView.h
//  Kitalker
//
//  Created by 杨 烽 on 12-8-4.
//
//

#import <UIKit/UIKit.h>
#import "UIView+KIAdditions.h"
#import "UIImage+KIAdditions.h"

typedef enum {
    KIImageFitWidth,
    KIImageFitHeight
} KIImageFitType;

@interface UIImageView (KIAdditions)

+ (CGSize)sizeToFit:(KIImageFitType)fitType withValue:(CGFloat)value withImage:(UIImage *)image;

+ (CGSize)sizeToFit:(KIImageFitType)fitType withValue:(CGFloat)value withImageSize:(CGSize)imageSize;

- (void)setImage:(UIImage *)image fitType:(KIImageFitType)fitType withValue:(CGFloat)value;

@end
