//
//  SignUpViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/8/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"
#import "SqlLiteDatabaseMethods.h"
#import "LearningMethods.h"

@interface SignUpViewController ()


@property (weak, nonatomic) IBOutlet UITextField *UsernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoField;
- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LearningMethods dismissKeyboardWhenPressed:self.view];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/

/*
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

-(BOOL)validateFields{
    if ([self.UsernameField.text isEqualToString:@""]){
        [LearningMethods showUIAlertMessage:@"Username Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }
    if ([self.passwordField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"Password Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }
    if ([self.firstNameField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"First Name Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }
    /*if ([self.lastNameField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"Last Name Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }*/
    if ([self.emailField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"Email Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }
    if ([self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
    }
    else{
        [LearningMethods showUIAlertMessage:@"Password did not match" andWithTitle:@"Error" andInView:self.navigationController];
        return NO;
    }
    return YES;
}

- (IBAction)saveButton:(id)sender {
    if([self validateFields]){
        NSString * sqlStatement = [NSString stringWithFormat:@"INSERT INTO Users (Username,Password,FirstName,LastName,PhoneNo,EmailID) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", self.UsernameField.text,self.passwordField.text,self.firstNameField.text,self.lastNameField.text,self.phoneNoField.text,self.emailField.text];
        [SqlLiteDatabaseMethods InsertData:sqlStatement andSuccessMessage:@"insert data successfull" andFailureMessage:@"Did not insert data"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (IBAction)cancelButton:(id)sender {
}

@end
