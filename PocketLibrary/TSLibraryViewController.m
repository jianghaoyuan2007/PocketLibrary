//
//  TSLibraryViewController.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 11/04/2018.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSLibraryViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TSResource.h"
#import "TSResourceManager.h"
#import "TSUploadServer.h"

@interface TSLibraryViewController ()

- (void)reload;

@end

@implementation TSLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.resource.name;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resourceDidChangeNotification)
                                                 name: TSUploadServerResourceDidChangedNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.resource.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *reuseIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    TSResource *item = self.resource.items[indexPath.row];
    
    cell.textLabel.text = item.name;
    
    if (item.isDirectory) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TSResource *item = self.resource.items[indexPath.row];

    if (item.isDirectory) {
        
        TSLibraryViewController *viewController = [TSLibraryViewController new];
        
        viewController.resource = item;
        
        [self.navigationController pushViewController:viewController animated:YES];
    } else {
        
        NSURL *mediaURL = [NSURL fileURLWithPath:item.path];
        
        AVPlayerViewController *viewController = [[AVPlayerViewController alloc] init];
        
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:mediaURL];
        
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        
        [player play];

        viewController.player = player;
        
        [self presentViewController:viewController animated:YES completion:nil];
    }
}

#pragma mark - Private Methods

- (void)reload {
    
    [self.resource reload];
    
    [self.tableView reloadData];
}

- (void)resourceDidChangeNotification {
    
    [self reload];
}
@end
