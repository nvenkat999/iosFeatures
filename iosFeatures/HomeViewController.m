//
//  HomeViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/21/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "GetServiceViewController.h"
#import "AppDelegate.h"
#import "ImageViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(rightRevealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootViewControllerAnimated) name:@"popToRoot" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        if (indexPath.section == 2)
         {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MapsStoryBoard" bundle:nil];
        UIViewController *mapViewController = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
        [self.navigationController pushViewController:mapViewController animated:YES];
        
        //SWRevealViewControllerSeguePushController *segue = [[SWRevealViewControllerSeguePushController alloc] initWithIdentifier:@"test" source:self destination:getServiceViewController];
        //SWRevealViewControllerSeguePushController *segue
        //[segue perform];
         }
       
    }
    else if (indexPath.row==2){
        if (indexPath.section ==2) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"AppPurchasesStoryBoard" bundle:nil];
            UIViewController *purchaseViewController = [storyBoard instantiateViewControllerWithIdentifier:@"AppPurchaseViewController"];
            [self.navigationController pushViewController:purchaseViewController animated:YES];
        }
    }
}


//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    if ([[segue identifier] isEqualToString:@"takePhotoSegue"]) {
//        ImageViewController *imageView = [segue.destinationViewController];
//        //self.navigationController
//        
//        
//    }
//}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)popToRootViewControllerAnimated
{
    UIStoryboard * launchStoryBoard = [UIStoryboard storyboardWithName:@"LaunchScreenStoryBoard" bundle:nil];
    UIViewController * launchView = [launchStoryBoard instantiateViewControllerWithIdentifier:@"LaunchScreenViewController"];
    [self.navigationController pushViewController:launchView animated:YES];
    //[self.navigationController presentViewController:launchView animated:YES completion:nil];
}

@end
