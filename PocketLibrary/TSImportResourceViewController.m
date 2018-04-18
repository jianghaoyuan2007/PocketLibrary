//
//  TSImportResourceViewController.m
//  PocketLibrary
//
//  Created by Stephen Chiang on 2018/4/18.
//  Copyright © 2018 net.stephenchiang. All rights reserved.
//

#import "TSImportResourceViewController.h"
#import "TSUploadServer.h"

@interface TSImportResourceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@end

@implementation TSImportResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Import Resources";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(closeBarButtonItemTapped)];
    
    self.navigationItem.leftBarButtonItem = item;
    
    [[TSUploadServer sharedInstance] startup];
    
    self.descriptionView.text = [NSString stringWithFormat:@"There are several steps to import resources with WebDAV client: \n\
Step 1: Open Finder app on your mac OS. \n\
Step 2: Click \"Go\" on Finder app menu. \n\
Step 3: Click \"Connect to Server ...\", then the \"Connect to Server\" window will show.\n\
Step 4: Type \"%@\" to the input box of Server Address.\n\
Step 5: Click \"Connect\" button to connect the server of Pocket Library.\n\
Step 6: Click \"Connect\" button to continue connect the server if the window of Unsecured Connection shown.\n\
Step 7: Select Guest option as type of connect and click \"Connect\" if the window of Enter your name and password for the server shown.\n\
Step 8: Copy files to the new tab of Finder app.\n", [TSUploadServer sharedInstance].serverAddress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[TSUploadServer sharedInstance] shutdown];
}

- (void)closeBarButtonItemTapped {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
