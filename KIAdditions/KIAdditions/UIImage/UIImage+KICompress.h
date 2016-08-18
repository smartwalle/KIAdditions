//
//  UIImage+KICompress.h
//  Kitalker
//
//  Created by 杨 烽 on 12-8-3.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (KICompress)

// 对图片进行压缩，返回压缩之后的 data
// maxSize 为想要压缩到的最大文件大小，该值只是一个理想值，不一定会达到；
// minCompression 为压缩之后的最小质量；
// maxResolution 为压缩之后最大分辨率；
- (NSData *)compressToMaxSize:(NSInteger)maxSize
                 minCompression:(CGFloat)minCompression
                  maxResolution:(CGFloat)maxResolution;
@end
