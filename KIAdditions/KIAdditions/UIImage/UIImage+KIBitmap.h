//
//  UIImage+Bitmap.h
//  KIAdditions
//
//  Created by apple on 16/3/22.
//  Copyright © 2016年 smartwalle. All rights reserved.
//
// Thanks http://stackoverflow.com/questions/25126772/objective-c-save-uiimage-as-a-bmp-file

#import <UIKit/UIKit.h>

@interface UIImage (KIBitmap)

- (NSData *)bitmapData;

- (UIImage *)bitmapImage;

@end
