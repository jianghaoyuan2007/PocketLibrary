//
//  TSUploadServer.h
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSUploadServer : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isRunning;

- (void)startup;

- (void)shutdown;

@end
