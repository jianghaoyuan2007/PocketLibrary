//
//  TSResource.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSResource.h"
#import "TSResourceManager.h"

@interface TSResource()

- (NSArray *)fetchResouces;

@end

@implementation TSResource

- (instancetype)initWithPath:(NSString *)path {
    
    if (self = [super init]) {
        
        _name = [path lastPathComponent];
        
        _fileType = [TSResourceManager typeOfFilePath:path];
        
        _parentDirectory = [path stringByDeletingLastPathComponent];
        
        _isDirectory = [TSResourceManager isDirectoryOfPath:path];
        
        _path = path;

        _items = [self fetchResouces];
    }
    
    return self;
}

+ (instancetype)webRootResource {
    
    TSResource *resource = [[TSResource alloc] initWithPath:[TSResourceManager webRootDirectory]];

    return resource;
}

- (void)reload {
    
    _items = [self fetchResouces];
}

#pragma mark - Private Methods

- (NSArray *)fetchResouces {
    
    NSArray *paths = [TSResourceManager listInPath:self.path];
    
    NSMutableArray *resources = [NSMutableArray arrayWithCapacity:paths.count];
    
    for (NSString *path in paths) {
        
        TSResource *resource = [[TSResource alloc] initWithPath:path];
        
        [resources addObject:resource];
    }

    return [NSArray arrayWithArray:resources];
}

@end
