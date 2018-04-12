//
//  TSUploadServer.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSUploadServer.h"
#import <GCDWebServer/GCDWebDAVServer.h>
#import <GCDWebServer/GCDWebUploader.h>
#import "TSResourceManager.h"

NSString * const TSUploadServerResourceDidChangedNotification = @"TSUploadServerResourceDidChangedNotification";

@interface TSUploadServer()<GCDWebDAVServerDelegate>

@property (nonatomic, strong) GCDWebDAVServer *uploader;

- (void)resourceDidUpdate;

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
        
        self.uploader = [[GCDWebDAVServer alloc] initWithUploadDirectory:directory];
        
        self.uploader.delegate = self;
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

- (void)resourceDidUpdate {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TSUploadServerResourceDidChangedNotification
                                                        object:nil];
}

#pragma mark - GCDWebDAVServerDelegate Methods

/**
 *  This method is called whenever a file has been downloaded.
 */
- (void)davServer:(GCDWebDAVServer*)server didDownloadFileAtPath:(NSString*)path {
    
    [self resourceDidUpdate];
}

/**
 *  This method is called whenever a file has been uploaded.
 */
- (void)davServer:(GCDWebDAVServer*)server didUploadFileAtPath:(NSString*)path {
    
    [self resourceDidUpdate];
}

/**
 *  This method is called whenever a file or directory has been moved.
 */
- (void)davServer:(GCDWebDAVServer*)server didMoveItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
    
    [self resourceDidUpdate];
}

/**
 *  This method is called whenever a file or directory has been copied.
 */
- (void)davServer:(GCDWebDAVServer*)server didCopyItemFromPath:(NSString*)fromPath toPath:(NSString*)toPath {
 
    [self resourceDidUpdate];
}

/**
 *  This method is called whenever a file or directory has been deleted.
 */
- (void)davServer:(GCDWebDAVServer*)server didDeleteItemAtPath:(NSString*)path {
    
    [self resourceDidUpdate];
}

/**
 *  This method is called whenever a directory has been created.
 */
- (void)davServer:(GCDWebDAVServer*)server didCreateDirectoryAtPath:(NSString*)path {
    
    [self resourceDidUpdate];
}

@end
