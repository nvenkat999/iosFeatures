//
//  AlertViewControllerMethods.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/23/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "AlertViewControllerMethods.h"

@interface AlertViewControllerMethods ()

@end

@implementation AlertViewControllerMethods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:Nil];
}


@end
