//
//  CustomCameraViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/16/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>




@interface CustomCameraViewController : ViewController<AVCapturePhotoCaptureDelegate,MFMessageComposeViewControllerDelegate>



@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *captureImageButton;

@property (weak, nonatomic) IBOutlet UIButton *flipCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak,nonatomic) IBOutlet UIButton *cancelImageButton;
@property (weak,nonatomic) IBOutlet UIImageView *captureImageView;
@property (strong,nonatomic)IBOutlet UIImage *imageCaptured;


-(UIButton *)createButton:(CGRect)frame image:(NSString *)imageName action:(SEL)action parentView:(UIView*)parentView;
-(void)closeImageView:(id)sender;

@end
