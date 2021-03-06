//
//  QuestionViewController.h
//  Presentice
//
//  Created by レー フックダイ on 12/24/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AWSRuntime/AWSRuntime.h>
#import <AWSS3/AWSS3.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "Constants.h"

#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface QuestionViewController : UIViewController <UINavigationControllerDelegate, UINavigationBarDelegate, UIAlertViewDelegate, AmazonServiceRequestDelegate, UIImagePickerControllerDelegate>


// For display questionVideo
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UILabel *fileLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (copy, nonatomic)NSURL *movieURL;
@property (strong, nonatomic) PFObject *questionVideoObj;
@property (strong, nonatomic)MPMoviePlayerController *movieController;

// For taking answerVideo
- (IBAction)takeAnswer:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *putObjectTextField;
@property (nonatomic, strong) S3TransferManager *tm;
- (BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@property (strong, nonatomic) NSString *answerVideoName;
@property (strong, nonatomic) NSString *answerVideoVisibility;

@end
