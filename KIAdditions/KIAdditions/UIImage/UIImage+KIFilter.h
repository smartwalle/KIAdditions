//
//  UIImage+KIFilter.h
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KIFilter)

// https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
- (UIImage *)imageWithFilterName:(NSString *)filterName;

- (UIImage *)linearToSRGBToneCurve;

- (UIImage *)photoEffectChrome;

- (UIImage *)photoEffectFade;

- (UIImage *)photoEffectInstant;

- (UIImage *)photoEffectMono;

- (UIImage *)photoEffectNoir;

- (UIImage *)photoEffectProcess;

- (UIImage *)photoEffectTonal;

- (UIImage *)photoEffectTransfer;

- (UIImage *)SRGBToneCurveToLinear;

- (UIImage *)vignetteEffect;

@end
