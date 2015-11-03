//
//  NSFileManager+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-11-29.
//
//

#import "NSFileManager+KIAdditions.h"

@implementation NSFileManager (KIAdditions)

+ (BOOL)fileExistsAtPath:(NSString *)path {
    NSFileManager *defaults = [NSFileManager defaultManager];
    return [defaults fileExistsAtPath:path];
}

+ (BOOL)directoryExistsAtPath:(NSString *)path {
    NSFileManager *defaults = [NSFileManager defaultManager];
    BOOL isDir = NO;
    [defaults fileExistsAtPath:path isDirectory:&isDir];
    return isDir;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path {
    NSFileManager *defaults = [NSFileManager defaultManager];
    BOOL exists = [NSFileManager directoryExistsAtPath:path];
    if (!exists) {
        return [defaults createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return exists;
}

+ (BOOL)removeItemAtPath:(NSString *)path {
    NSFileManager *defaults = [NSFileManager defaultManager];
    
    if ([NSFileManager directoryExistsAtPath:path] || [NSFileManager fileExistsAtPath:path]) {
        return [defaults removeItemAtPath:path error:nil];
    }
    return YES;
}

+ (NSString *)filePathBaseDocument:(NSString *)path fileName:(NSString *)fileName {
    return [NSFileManager filePathWithBaseDirectory:KIDirectoryBaseDocument(path) fileName:fileName];
}

+ (NSString *)filePathBaseLibrary:(NSString *)path fileName:(NSString *)fileName {
    return [NSFileManager filePathWithBaseDirectory:KIDirectoryBaseLibrary(path) fileName:fileName];
}

+ (NSString *)filePathBaseCaches:(NSString *)path fileName:(NSString *)fileName {
    return [NSFileManager filePathWithBaseDirectory:KIDirectoryBaseCaches(path) fileName:fileName];
}

+ (NSString *)filePathBaseTmp:(NSString *)path fileName:(NSString *)fileName {
    return [NSFileManager filePathWithBaseDirectory:KIDirectoryBaseTmp(path) fileName:fileName];
}

+ (NSString *)filePathWithBaseDirectory:(NSString *)basePath fileName:(NSString *)fileName {
    if ([NSFileManager createDirectoryAtPath:basePath]) {
        return [basePath stringByAppendingPathComponent:fileName?fileName:@""];
    }
    return nil;
}

+ (void)createFilePathsIfNotExists:(NSArray *)paths {
    NSFileManager *defaults = [NSFileManager defaultManager];
    [paths enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL isDir = NO;
        
        [defaults fileExistsAtPath:obj isDirectory:&isDir];
        
        if (!isDir) {
            [defaults createDirectoryAtPath:obj
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:nil];
        }
        
    }];
}

@end
