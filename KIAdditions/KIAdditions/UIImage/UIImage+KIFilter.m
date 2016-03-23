//
//  UIImage+KIFilter.m
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import "UIImage+KIFilter.h"

@implementation UIImage (KIFilter)

- (UIImage *)imageWithFilterName:(NSString *)filterName {
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, image, nil];
    [filter setDefaults];
    CIImage *outputImage = [filter outputImage];
    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
//    UIImage *result = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
    
    UIImage *result = [UIImage imageWithCIImage:outputImage];
    
    return result;
}

- (UIImage *)linearToSRGBToneCurve {
    return [self imageWithFilterName:@"CILinearToSRGBToneCurve"];
}

- (UIImage *)photoEffectChrome {
    return [self imageWithFilterName:@"CIPhotoEffectChrome"];
}

- (UIImage *)photoEffectFade {
    return [self imageWithFilterName:@"CIPhotoEffectFade"];
}

- (UIImage *)photoEffectInstant {
    return [self imageWithFilterName:@"CIPhotoEffectInstant"];
}

- (UIImage *)photoEffectMono {
    return [self imageWithFilterName:@"CIPhotoEffectMono"];
}

- (UIImage *)photoEffectNoir {
    return [self imageWithFilterName:@"CIPhotoEffectNoir"];
}

- (UIImage *)photoEffectProcess {
    return [self imageWithFilterName:@"CIPhotoEffectProcess"];
}

- (UIImage *)photoEffectTonal {
    return [self imageWithFilterName:@"CIPhotoEffectTonal"];
}

- (UIImage *)photoEffectTransfer {
    return [self imageWithFilterName:@"CIPhotoEffectTransfer"];
}

- (UIImage *)SRGBToneCurveToLinear {
    return [self imageWithFilterName:@"CISRGBToneCurveToLinear"];
}

- (UIImage *)vignetteEffect {
    return [self imageWithFilterName:@"CIVignetteEffect"];
}

@end
