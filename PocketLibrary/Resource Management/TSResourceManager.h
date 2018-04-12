//
//  TSResourceManager.h
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSResourceManager : NSObject

+ (NSString *)webRootDirectory;

+ (void)createWebRootDirectory;

+ (NSArray<NSString *> *)listInPath:(NSString *)path;

+ (NSString *)locateResourceInPath:(NSString *)path name:(NSString *)name;

+ (NSString *)typeOfFilePath:(NSString *)path;

+ (BOOL)isDirectoryOfPath:(NSString *)path;

@end
