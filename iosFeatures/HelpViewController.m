//
//  HelpViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/27/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
- (IBAction)doneBarButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *helpView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    NSURL *helpURL = [[NSBundle mainBundle] URLForResource:@"help" withExtension:@"pdf"];
    NSURLRequest * request = [NSURLRequest requestWithURL:helpURL];
    [_helpView loadRequest:request];
    // Do any additional setup after loading the view.
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

- (IBAction)doneBarButton:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
