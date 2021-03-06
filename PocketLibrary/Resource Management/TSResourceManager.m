//
//  TSResourceManager.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSResourceManager.h"
#import <FCFileManager/FCFileManager.h>

@implementation TSResourceManager

+ (NSString *)webRootDirectory {
    
    NSString *directory = @"Library";
    
    return [FCFileManager pathForDocumentsDirectoryWithPath:directory];
}

+ (void)createWebRootDirectory {
    
    if (![FCFileManager existsItemAtPath:[TSResourceManager webRootDirectory]]) {
        
        [FCFileManager createDirectoriesForPath:[TSResourceManager webRootDirectory]];
    }
}

+ (NSArray<NSString *> *)listInPath:(NSString *)path {
    
    NSArray *files = [FCFileManager listItemsInDirectoryAtPath:path deep:NO];
    
    return [files sortedArrayUsingSelector:@selector(compare:)];
}

+ (NSString *)locateResourceInPath:(NSString *)path name:(NSString *)name {
    
    return [path stringByAppendingPathComponent:name];
}

+ (NSString *)typeOfFilePath:(NSString *)path {
    
    return [FCFileManager attributeOfItemAtPath:path forKey:NSFileType];
}

+ (BOOL)isDirectoryOfPath:(NSString *)path {
    
    return [FCFileManager isDirectoryItemAtPath:path];
}

@end
