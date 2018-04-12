//
//  TSLibraryViewController.h
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TSResource;

@interface TSLibraryViewController : UITableViewController

@property (nonatomic, strong) TSResource *resource;

@end
