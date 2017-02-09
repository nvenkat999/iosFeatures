//
//  ScanBarcodeViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/20/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "ScanBarcodeViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AlertViewMethods.h"

@interface ScanBarcodeViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property AVCaptureSession *session;
@property AVCaptureDevice *captureDevice;
@property AVCaptureDeviceInput *deviceInput;
@property AVCaptureMetadataOutput *deviceOutput;
@property UIView *previewLayer;
@property (strong, nonatomic) IBOutlet UIView *cameraView;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;



@end

@implementation ScanBarcodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{

    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    _captureDevice =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    if ([_session canAddInput:_deviceInput]) {
        [_session addInput:_deviceInput];
    }

    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:_session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer setMasksToBounds:YES];
    CGRect frame= self.view.frame;
    [previewLayer setFrame:frame];
    [self.view.layer addSublayer:previewLayer];

    _deviceOutput = [[AVCaptureMetadataOutput alloc]init];
    [_session addOutput:_deviceOutput];
    
    [_deviceOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    _deviceOutput.metadataObjectTypes = [_deviceOutput availableMetadataObjectTypes];
    
    [_session startRunning];
    
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    //CGRect highlightBarcodeView = CGRectZero;
    //AVMetadataMachineReadableCodeObject *barcodeObject;
    NSString *barcodeString =nil;
    NSArray *barcodeTypes = @[AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode];
    
    for (AVMetadataObject *dataObject in metadataObjects) {
        for (NSString *type in barcodeTypes) {
            if ([dataObject.type isEqualToString:type]) {
                barcodeString = [(AVMetadataMachineReadableCodeObject *)dataObject stringValue];
                
               // barcodeObject = (AVMetadataMachineReadableCodeObject *)[_previewLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)dataObject];
                //highlightBarcodeView = barcodeObject.bounds;
                
                break;
            }
        }
        if((barcodeString !=nil)){
            [self.session stopRunning];
            if ((dataObject.type == AVMetadataObjectTypeCode39Code)) {
                NSString *str =[NSString stringWithFormat:@"Barcode value is %@",barcodeString];
                [self showUIAlertMessage:str andWithTitle:@"Scan value"];
            }
            else {
               [self showUIAlertMessage:@"Barcode is not of Code39 type, this app can use only code 39 type barcode" andWithTitle:@"Scan Error"];
                //[AlertViewMethods showUIAlertMessage:@"Barcode is not of Code39 type, this app can use only code 39 type barcode"  andWithTitle:@"Scan error"];
                //NSLog(@"Barcode is not of Code 39 type.");
            }
            
        }
    }
   
    
}

-(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.session startRunning];
    }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


     
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
