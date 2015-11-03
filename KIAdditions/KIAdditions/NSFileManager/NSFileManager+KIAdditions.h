//
//  NSFileManager+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-11-29.
//
//

#import <Foundation/Foundation.h>
#import "NSBundle+KIAdditions.h"

/*返回文件夹的路径，并且会创建文件目录*/
#define KIFilePathBaseDocument(path, name)  [NSFileManager filePathBaseDocument:path fileName:name]
#define KIFilePathBaseLibrary(path, name)   [NSFileManager filePathBaseLibrary:path fileName:name]
#define KIFilePathBaseCaches(path, name)    [NSFileManager filePathBaseCaches:path fileName:name]
#define KIFilePathBaseTmp(path, name)       [NSFileManager filePathBaseTmp:path fileName:name]

@interface NSFileManager (KIAdditions)

+ (BOOL)fileExistsAtPath:(NSString *)path;

+ (BOOL)directoryExistsAtPath:(NSString *)path;

+ (BOOL)createDirectoryAtPath:(NSString *)path;

+ (BOOL)removeItemAtPath:(NSString *)path;

+ (NSString *)filePathBaseDocument:(NSString *)path fileName:(NSString *)fileName;

+ (NSString *)filePathBaseLibrary:(NSString *)path fileName:(NSString *)fileName;

+ (NSString *)filePathBaseCaches:(NSString *)path fileName:(NSString *)fileName;

+ (NSString *)filePathBaseTmp:(NSString *)path fileName:(NSString *)fileName;

+ (void)createFilePathsIfNotExists:(NSArray *)paths;

@end
