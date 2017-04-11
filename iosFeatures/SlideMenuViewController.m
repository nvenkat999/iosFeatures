//
//  SlideMenuViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/20/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "HelpViewController.h"

@interface SlideMenuViewController ()



@end

@implementation SlideMenuViewController
NSArray * menu;

- (void)viewDidLoad {
    [super viewDidLoad];
    _width = (self.view.frame.size.width);
    _tableHeight = self.view.frame.size.height;
    _tableWidth = _width-60;
    //_startingPoint = _width* 0.1875;
    
}

-(void)viewDidAppear:(BOOL)animated{
   
//    CGRect frame = CGRectMake(0, 0, width, cellHeight);
    
   // [self.tableView setFrame:CGRectMake(60, 0, _tableWidth, _tableHeight)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
    //return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    _cellHeight = cell.contentView.frame.size.height;
    CGFloat cellWidth = (self.tableView.frame.size.width)-60;
    CGRect frame = CGRectMake(60, 0, cellWidth, _cellHeight);
    
    if (indexPath.row == 0) {
        UIButton * button = [self CreateWithName:@"Logout" andFrame:frame andAction:@selector(logout:)];
        [cell.contentView addSubview:button];
        }
    if (indexPath.row == 1) {
        UIButton * button = [self CreateWithName:@"User Profile" andFrame:frame andAction:@selector(userProfile:)];
        [cell.contentView addSubview:button];
    }
    if (indexPath.row == 2) {
        UIButton * button = [self CreateWithName:@"Settings" andFrame:frame andAction:@selector(settings:)];
        [cell.contentView addSubview:button];
    }
    if (indexPath.row == 3) {
        UIButton * button = [self CreateWithName:@"Help" andFrame:frame andAction:@selector(help:)];
        [cell.contentView addSubview:button];
    }
    if (indexPath.row == 4) {
        UIButton * button = [self CreateWithName:@"CallMe" andFrame:frame andAction:@selector(callMe:)];
        [cell.contentView addSubview:button];
    }
    if (indexPath.row == 5) {
        UIButton * button = [self CreateWithName:@"Version" andFrame:frame andAction:@selector(version:)];
        [cell.contentView addSubview:button];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
 */

-(UIButton *) CreateWithName:(NSString*)name andFrame:(CGRect)frame andAction:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:frame];
    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTintColor:[UIColor brownColor]];
    [button.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//    [button setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    return  button;
}

/*
-(void)addButtonsToView{
    NSInteger rowIndex =0;
    NSIndexPath * cellIndex;
    //cellIndex = [NSIndexPath indexPathWithIndex:rowIndex];
    cellIndex = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    CGRect frame = CGRectMake(0, 0, 320, 40);
    UIButton * button = [self CreateWithName:@"Logout" andFrame:frame andAction:@selector(Logout:)];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:cellIndex];
    [cell addSubview:button];
    //NSIndexPath *indexPath =2;
    rowIndex++;
    button = [self CreateWithName:@"Call Me" andFrame:frame andAction:@selector(CallMe:)];
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:cellIndex];
    [cell addSubview:button];
    
    
    //UITableViewCell *cell = [UITableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:0];
   // [self.tableView addSubview:button];
}

 */

-(void)logout:(id)sender{
    NSLog(@"This is logout button");
    //[self.revealViewController rightRevealToggle:sender];
   UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Do you really want to logout" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        UIStoryboard * loginScreenStoryBoard = [UIStoryboard storyboardWithName:@"LoginStoryBoard" bundle:nil];
        UIViewController *loginViewController = [loginScreenStoryBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //[self.navigationController pushViewController:loginViewController animated:YES];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
    }];
        [alert addAction:confirmAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)userProfile:(id)sender{
    NSLog(@"This is Userprofile button");
    //[self.revealViewController rightRevealToggle:sender];
    UIStoryboard *slideMenuStoryBoard = [UIStoryboard storyboardWithName:@"SlideMenuStoryBoard" bundle:nil];
    UIViewController *userProfileViewController = [slideMenuStoryBoard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [self presentViewController:userProfileViewController animated:YES completion:nil];
    
}

-(void)settings:(id)sender{
    NSLog(@"This is settings button");
}

-(void)help:(id)sender{
    NSLog(@"This is help button");
    //[self.revealViewController rightRevealToggle:sender];
    UIStoryboard *slideMenuStoryBoard = [UIStoryboard storyboardWithName:@"SlideMenuStoryBoard" bundle:nil];
    UIViewController *helpViewController = [slideMenuStoryBoard instantiateViewControllerWithIdentifier:@"HelpViewController"];
    [self presentViewController:helpViewController animated:YES completion:nil];
}


-(void)callMe:(id)sender{
NSLog(@"This is Call me button");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"224-480-9380" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:@"Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
       // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1-224-480-9380"] options:nil completionHandler:nil];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://1-224-480-9380"]];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://1-224-480-9380"] options:@{} completionHandler:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    [alert addAction:callAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

    //CGFloat awidth = self.view.frame.size.width;
    //CGFloat astartingposition = self.view.frame.origin.x;
    
}


-(void)version:(id)sender{
    NSLog(@"This is version button");
    //[self.revealViewController rightRevealToggle:sender];
    UIStoryboard *slideMenuStoryBoard = [UIStoryboard storyboardWithName:@"SlideMenuStoryBoard" bundle:nil];
    UIViewController *versionViewController = [slideMenuStoryBoard instantiateViewControllerWithIdentifier:@"VersionViewController"];
    [self presentViewController:versionViewController animated:YES completion:nil];
}


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

@end
