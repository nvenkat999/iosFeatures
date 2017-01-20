//
//  LearningMethods.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/7/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "LearningMethods.h"

@interface LearningMethods ()

@end

@implementation LearningMethods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)dismissKeyboardWhenPressed:(UIView *)sampleView{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taprecognized:)];
    [sampleView addGestureRecognizer:tapRecognizer];
    
}

+(void)taprecognized:(UITapGestureRecognizer *)tap{
    UIView *tapview = tap.view;
    [tapview endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

+(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title andInView:(UIViewController *)presentView{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    [presentView presentViewController:alert animated:YES completion:nil];
}

+(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    //[self presentViewController:alertDisplay animated:YES completion:Nil];
}

@end
