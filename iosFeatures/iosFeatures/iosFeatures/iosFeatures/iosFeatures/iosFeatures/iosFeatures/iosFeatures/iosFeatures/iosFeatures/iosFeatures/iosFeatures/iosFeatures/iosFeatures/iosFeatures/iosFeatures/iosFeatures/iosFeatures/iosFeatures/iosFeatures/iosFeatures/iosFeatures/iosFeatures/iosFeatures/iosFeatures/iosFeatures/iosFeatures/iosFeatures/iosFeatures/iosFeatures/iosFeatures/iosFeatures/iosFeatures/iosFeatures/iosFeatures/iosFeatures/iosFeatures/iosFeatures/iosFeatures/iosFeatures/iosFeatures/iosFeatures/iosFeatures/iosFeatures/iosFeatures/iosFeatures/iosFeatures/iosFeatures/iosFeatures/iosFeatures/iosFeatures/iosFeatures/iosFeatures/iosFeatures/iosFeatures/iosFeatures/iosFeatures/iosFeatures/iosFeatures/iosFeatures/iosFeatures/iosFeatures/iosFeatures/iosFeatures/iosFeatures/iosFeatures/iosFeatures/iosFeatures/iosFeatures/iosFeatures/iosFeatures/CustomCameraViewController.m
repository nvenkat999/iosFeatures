//
//  CustomCameraViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/16/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "CustomCameraViewController.h"
#import "HomeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import "LearningMethods.h"
#import "MBProgressHUD.h"

@interface CustomCameraViewController ()

@property AVCaptureSession *session;
@property AVCapturePhotoOutput *imageOutput;
@property AVCaptureDevice *device;
@property AVCaptureDeviceInput *deviceInput;
@property AVCapturePhotoSettings *imageSettings;

@end

@implementation CustomCameraViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _captureImageButton.layer.cornerRadius = 35 ;
    _captureImageButton.opaque = false;
    
    // Do any additional setup after loading the view.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    //initializing sessions
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    //Initializing device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    //Initializing device input
    
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
    if ([_session canAddInput:_deviceInput]) {
        [_session addInput:_deviceInput];
    }
    //Initializing previw layer and setting to our view
    
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.cameraView.layer setMasksToBounds:YES];
    CGRect frame = self.cameraView.frame;
    [previewLayer setFrame:frame];
    [self.cameraView.layer insertSublayer:previewLayer atIndex:0];
    
    //Initializing output and adding it to session
    _imageOutput = [[AVCapturePhotoOutput alloc]init];
    [_session addOutput:_imageOutput];
    [_session startRunning];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
}





- (IBAction)flipCameraAction:(id)sender {
    NSLog(@"flip Camera");
    
    if(_session){
        [_session beginConfiguration];
        //removing current input
        
        AVCaptureDeviceInput * currentInput = [_session.inputs objectAtIndex:0];
        [_session removeInput:currentInput];
        
        //creating new Device
        AVCaptureDevice *newDevice = nil;
        if (((AVCaptureDeviceInput *)currentInput).device.position == AVCaptureDevicePositionBack) {
            newDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
        } else {
            newDevice =[AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        }
        NSError *error = nil;
        //Creating new input
        
        AVCaptureDeviceInput *newDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:newDevice error:&error];
        if (newDeviceInput) {
            [_session addInput:newDeviceInput];
        } else {
            NSLog(@"new device input is not displaying: %@",error);
        }
        //Commiting configuration changes
        [_session commitConfiguration];
    }
    
    
}

- (IBAction)captureImageAction:(id)sender {
    if (_session) {
        NSLog(@"Session running");
        AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettings];
        
        [self.imageOutput capturePhotoWithSettings:settings delegate:self];
    }else{
        NSLog(@"Session not running");
    }

}



-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }

    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        _imageCaptured = [UIImage imageWithData:data];
       [self.captureImageView setImage:_imageCaptured];
       self.captureImageView.hidden = false;
        [self startImageView];
        _captureImageView.userInteractionEnabled= true;

        
       
    }
}




-(void)startImageView{
    CGRect imageFrame = _captureImageView.frame;
    
    UIButton *cancelImageButton = [self createButton:CGRectMake(8, 8, 50, 50) image: @"photo_close_icon" action:@selector(closeImageView:) parentView:_captureImageView];
    UIButton *saveImageButton = [self createButton:CGRectMake(8, imageFrame.size.height-58, 50, 30) image: @"" action:@selector(saveImageAction:) parentView:_captureImageView];
    [saveImageButton setTitle:@"Save" forState:UIControlStateNormal];
    UIButton *sendImageButton = [self createButton:CGRectMake(imageFrame.size.width-48, imageFrame.size.height-58, 50, 30) image: @"" action:@selector(sendImageAction:) parentView:_captureImageView];
    [sendImageButton setTitle:@"Send" forState:UIControlStateNormal];
}

-(void)closeImageView:(id)sender{
    
    _captureImageView.hidden = true;
}

-(void)saveImageAction:(id)sender{
    if (_imageCaptured) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        UIImageWriteToSavedPhotosAlbum(_imageCaptured, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        });
    } else {
        NSLog(@"No photocaptured");
    }
    
}



- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Cancel action is done");
}

-(UIButton *)createButton:(CGRect)frame image:(NSString *)imageName action:(SEL)action parentView:(UIView*)parentView{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:button];
    button.userInteractionEnabled = YES;
    //button.backgroundColor = [UIColor redColor];
    return button;
}

- (void)image:(UIImage *) image didFinishSavingWithError: (NSError *) error
  contextInfo: (void *) contextInfo{
    if(error){
        UIAlertController *alertDisplay = [UIAlertController alertControllerWithTitle:@"Error" message:@"Photo did not saved" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertDisplay addAction:okAction];
        [self presentViewController:alertDisplay animated:YES completion:Nil];
    }else{
        NSLog(@"image saved");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [hud hideAnimated:YES];
//        });

    }
}

#pragma mark -Messaging functions
-(void)sendImageAction:(id)sender{
    
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
    if([MFMessageComposeViewController canSendText])
    {
        
        MFMessageComposeViewController *messagePicker =[[MFMessageComposeViewController alloc]init];
        messagePicker.messageComposeDelegate = self;
        
    [messagePicker addAttachmentData:UIImageJPEGRepresentation(_imageCaptured, 1.0) typeIdentifier:@"public.data" filename:@"image.JPEG"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:messagePicker animated:YES completion:nil];
            [hud hideAnimated:YES];
            
        });
        
        
    
       
        
    }else{
        NSLog(@"Sorry, u dont have access to send message");
    }
        
      
        });
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result;
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end


/*

#pragma mark -AVCapturePhotoCaptureDelegate

@interface captureImageDelegate : NSObject<AVCapturePhotoCaptureDelegate>

@end

@implementation captureImageDelegate




-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if (error) {
        NSLog(@"error : %@", error.localizedDescription);
    }
    
    if (photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        //CustomImageViewController *imageView;
       // [self presentViewController:imageView animated:YES completion:nil];
       // [imageView.customImageView setImage:image];
       // [self._i]
    }
}

@end

*/
