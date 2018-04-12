//
//  TSUploadServer.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSUploadServer.h"
#import <GCDWebServer/GCDWebUploader.h>
#import "TSResourceManager.h"

@interface TSUploadServer()

@property (nonatomic, strong) GCDWebUploader *uploader;

@end

@implementation TSUploadServer

+ (instancetype)sharedInstance {
    static TSUploadServer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TSUploadServer alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        [TSResourceManager createWebRootDirectory];
        
        NSString *directory = [TSResourceManager webRootDirectory];
        
        self.uploader = [[GCDWebUploader alloc] initWithUploadDirectory:directory];
    }
    
    return self;
}

- (BOOL)isRunning {
    
    return self.uploader.isRunning;
}

- (void)startup {
    
    NSString *message = nil;
    
    if ([self.uploader start]) {
        
        message = [NSString stringWithFormat:NSLocalizedString(@"GCDWebServer running locally on port %i", nil), (int)self.uploader.port];
    } else {
        
        message = NSLocalizedString(@"GCDWebServer not running!", nil);
    }

    NSLog(@"%@", message);
}

- (void)shutdown {
    
    [self.uploader stop];
}

@end
