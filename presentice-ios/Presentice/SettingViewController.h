//
//  PhotoViewController.h
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "Constants.h"
#import "PushPermissionViewController.h"

@interface SettingViewController : UITableViewController <PushPermissionViewDataDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (strong, nonatomic) NSString *photoFilename;
@property (nonatomic, strong) NSMutableArray *menuItems;

@end
