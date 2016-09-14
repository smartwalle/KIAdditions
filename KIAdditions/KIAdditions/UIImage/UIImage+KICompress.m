//
//  UIImage+KICompress.m
//  Kitalker
//
//  Created by 杨 烽 on 12-8-3.
//
//

#import "UIImage+KICompress.h"
#import "UIImage+KIAdditions.h"

@implementation UIImage (KICompress)

- (NSData *)compressToMaxSize:(NSInteger)maxSize
                minCompression:(CGFloat)minCompression
                 maxResolution:(CGFloat)maxResolution {
    UIImage *image = self;

    CGFloat resolution = image.size.width * image.size.width;
    
    if (resolution > maxResolution) {
        CGFloat factor = sqrt(resolution / maxResolution) * 2;
        image = [self resizeTo:CGSizeMake(image.size.width / factor, image.size.height / factor)];
    }
    
    CGFloat compression = 1.0f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while (imageData.length > maxSize && compression > minCompression) {
        compression -= 0.1f;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    return imageData;
}

@end
