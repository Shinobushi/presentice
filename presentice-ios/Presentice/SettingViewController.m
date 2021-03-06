//
//  PhotoViewController.m
//  SidebarDemo
//
//  Created by Simon on 30/6/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@end


@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Start loading HUD
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Set the menu's display
    self.menuItems = [[NSMutableArray alloc] init];
    [self setMenuItems];
}

- (void)viewDidAppear:(BOOL)animated {
    // Hid all HUD after all objects appered
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"info";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // // Configure the cell
    
    UIImageView *thumbnailImageView = (UIImageView *)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:[[self.menuItems objectAtIndex:indexPath.row] objectForKey:@"image"]];
    
    UILabel *info = (UILabel *)[cell viewWithTag:101];
    info.text = [[self.menuItems objectAtIndex:indexPath.row] objectForKey:@"info"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"type = %@", [[self.menuItems objectAtIndex:indexPath.row] objectForKey:@"type"]);
    if ([[[self.menuItems objectAtIndex:indexPath.row] objectForKey:@"type"] isEqual:@"pushPermission"] ) {
        NSLog(@"get in side");
        PushPermissionViewController *destViewController = [[PushPermissionViewController alloc] initWithStyle:UITableViewStyleGrouped];
        if ([destViewController isKindOfClass:[PushPermissionViewController class]]) {
            destViewController.delegate = self;
        }
        destViewController.pushPermission = [[NSMutableDictionary alloc] initWithDictionary:[[PFUser currentUser] objectForKey:@"pushPermission"]];
//        [self presentViewController:destViewController animated:YES completion:nil];
        [self.navigationController pushViewController:destViewController animated:YES];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toLoginView"]) {
        [PFUser logOut];
    }
}

- (void) setMenuItems {
    
    NSMutableDictionary *username = [[NSMutableDictionary alloc] init];
    [username setObject:@"username" forKey:@"type"];
    [username setObject:[[PFUser currentUser] objectForKey:kUserDisplayNameKey] forKey:@"info"];
    [username setObject:@"myList.jpeg" forKey:@"image"];
    [self.menuItems addObject:username];
    
    NSMutableDictionary *email = [[NSMutableDictionary alloc] init];
    [email setObject:@"email" forKey:@"type"];
    [email setObject:[[PFUser currentUser] objectForKey:kUserEmailKey] forKey:@"info"];
    [email setObject:@"email.jpeg" forKey:@"image"];
    [self.menuItems addObject:email];
    
    NSMutableDictionary *location = [[NSMutableDictionary alloc] init];
    [location setObject:@"location" forKey:@"type"];
    [location setObject:[[[[PFUser currentUser] objectForKey:kUserProfileKey] objectForKey:@"location"] objectForKey:@"name"]  forKey:@"info"];
    [location setObject:@"map.png" forKey:@"image"];
    [self.menuItems addObject:location];
    
    NSMutableDictionary *hometown = [[NSMutableDictionary alloc] init];
    [hometown setObject:@"hometown" forKey:@"type"];
    [hometown setObject:[[[[PFUser currentUser] objectForKey:kUserProfileKey] objectForKey:@"hometown"] objectForKey:@"name"]  forKey:@"info"];
    [hometown setObject:@"map.png" forKey:@"image"];
    [self.menuItems addObject:hometown];
    
    
    NSDictionary *permission = [[PFUser currentUser] objectForKey:@"pushPermission"];
    NSMutableDictionary *pushPermission = [[NSMutableDictionary alloc] init];
    [pushPermission setObject:@"pushPermission" forKey:@"type"];
    [pushPermission setObject:[NSString stringWithFormat:@"viewed:%@, reviewed:%@, answered:%@",
                               [permission objectForKey:@"viewed"],
                               [permission objectForKey:@"reviewed"],
                               [permission objectForKey:@"answered"]] forKey:@"info"];
    [pushPermission setObject:@"map.png" forKey:@"image"];
    [self.menuItems addObject:pushPermission];
}

- (void)recieveData:(NSMutableArray *)pushPermission {
    
    [self setMenuItems];
}

@end
