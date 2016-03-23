//
//  UIImage+KIFilter.m
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import "UIImage+KIFilter.h"

@implementation UIImage (KIFilter)

- (UIImage *)grayscale {
    CIImage *beginImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIImage *blackAndWhite = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputImageKey, beginImage, @"inputBrightness", [NSNumber numberWithFloat:0.0], @"inputContrast", [NSNumber numberWithFloat:1.1], @"inputSaturation", [NSNumber numberWithFloat:0.0], nil].outputImage;
    
    
    CIImage *output = [CIFilter filterWithName:@"CIExposureAdjust" keysAndValues:kCIInputImageKey, blackAndWhite, @"inputEV", [NSNumber numberWithFloat:0.7], nil].outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgiimage = [context createCGImage:output fromRect:output.extent];
    UIImage *newImage = [UIImage imageWithCGImage:cgiimage scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(cgiimage);
    
    return newImage;
}

- (UIImage *)imageWithFilterName:(NSString *)filterName {
    CIImage *image = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, image, nil];
    [filter setDefaults];
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
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
