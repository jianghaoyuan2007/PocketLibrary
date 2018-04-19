//
//  TSResource.h
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSResource : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *fileType;

@property (nonatomic, copy, readonly) NSString *path;

@property (nonatomic, copy, readonly) NSString *parentDirectory;

@property (nonatomic, assign, readonly) BOOL isDirectory;

@property (nonatomic, strong, readonly) NSArray *items;

- (instancetype)initWithPath:(NSString *)path;

+ (instancetype)webRootResource;

- (void)reload;

@end
