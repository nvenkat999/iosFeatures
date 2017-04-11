//
//  AlertViewMethods.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/23/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "AlertViewMethods.h"
#import <AVFoundation/AVFoundation.h>

@implementation AlertViewMethods

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }else if ([rootViewController isKindOfClass:[UITabBarController class]]){
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    else if ([rootViewController presentedViewController]!=nil){
        rootViewController = [rootViewController presentedViewController];
    }
   [rootViewController presentViewController:alert animated:YES completion:Nil];
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
            //[self presentViewController:alertView animated:YES completion:nil];
            break;
        }
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    NSLog(@"Access Given");
                    
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

@end
