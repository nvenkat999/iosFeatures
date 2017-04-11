//
//  ImageViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/15/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "ImageViewController.h"
#import <AVfoundation/avfoundation.h>
#import <UIkit/UIkit.h>
#import <Photos/Photos.h>
#import "LearningMethods.h"

@interface ImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) UIImagePickerController *selectImagePicker;
@property (weak,nonatomic) UIImage *imageTaken;
- (IBAction)takePhotoButton:(id)sender;
- (IBAction)selectPhotoButton:(id)sender;
- (IBAction)savePhotoButton:(id)sender;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)takePhotoButton:(id)sender {

    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status ==AVAuthorizationStatusAuthorized){
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate=self;
        [_imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:_imagePicker animated:YES completion:nil];
        }
        else{
            [self isCameraAccessGiven];
        }
    
}

- (IBAction)selectPhotoButton:(id)sender {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
    
    _selectImagePicker = [[UIImagePickerController alloc]init];
    _selectImagePicker.delegate = self;
    [_selectImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:_selectImagePicker animated:YES completion:nil];
    }else{
        [self requestAuthorizationForPhotos];
    }
    
}

- (IBAction)savePhotoButton:(id)sender {
    if (_imageTaken) {
        UIImageWriteToSavedPhotosAlbum(_imageTaken, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else
    {
        NSLog(@"Cant save image");
    }
    
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _imageTaken = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_imageView setImage:_imageTaken];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}




-(void)isCameraAccessGiven{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status)
    {
            case AVAuthorizationStatusDenied:{
            
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Access alert" message:@"You have declined access to camera, if you want to change it please go to settings screen" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertView dismissViewControllerAnimated:YES completion:nil];
                
            }];
            UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                
            }];
            [alertView addAction:okAction];
            [alertView addAction:settingsAction];
            [self presentViewController:alertView animated:YES completion:nil];
            break;
        }
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    _imagePicker = [[UIImagePickerController alloc]init];
                    _imagePicker.delegate=self;
                    [_imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                    [self presentViewController:_imagePicker animated:YES completion:nil];
                    
                }
                else{
                    NSLog(@"Access not granted");
  
                }
            }];
            

            break;
        }
            
        default:
            break;
    }
}


-(void)requestAuthorizationForPhotos{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusDenied:{
            //return NO;
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Access Alert" message:@"You have declined access to your photos, if you want to change it please go to settings screen" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertView dismissViewControllerAnimated:YES completion:nil];
                
            }];
            UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                
            }];
            [alertView addAction:okAction];
            [alertView addAction:settingsAction];
            [self presentViewController:alertView animated:YES completion:nil];
            break;
            
        }
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status==PHAuthorizationStatusAuthorized) {
                    NSLog(@"authorized");
                    _selectImagePicker = [[UIImagePickerController alloc]init];
                    _selectImagePicker.delegate = self;
                    [_selectImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                    [self presentViewController:_selectImagePicker animated:YES completion:nil];                } else
                    {
                        NSLog(@"not authorized");
                    }
            }];
            break;
        }
        default:
            break;
    }
    
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
    }
}

@end





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




