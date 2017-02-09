//
//  LaunchScreenViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/5/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "LoginViewController.h"
#import "SqlLiteDatabaseMethods.h"
#import "LearningMethods.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [SqlLiteDatabaseMethods CreateDBandTables];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    UIStoryboard *aLoginStoryBoard = [UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
    UIViewController *loginviewt = (UIViewController *) [aLoginStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginviewt animated:YES];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
