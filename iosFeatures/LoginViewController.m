//
//  LoginViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/6/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "LoginViewController.h"
#import "LearningMethods.h"
#import "SqlLiteDatabaseMethods.h"
#import "sqlite3.h"
#import "LoginViewController.h"
#import "UserProfile.h"
#import "HelpViewController.h"
#import "AppDelegate.h"
#import <coredata/coredata.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong,nonatomic) NSMutableArray *loginUserData;
- (IBAction)signUpButton:(id)sender;
- (IBAction)loginButton:(id)sender;
- (IBAction)helpButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *enableTouchIDSwitch;

@end

@implementation LoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"its login screen");
    [LearningMethods dismissKeyboardWhenPressed:self.view];
    self.navigationController.navigationBarHidden = YES;
    [_autoLoginSwitch addTarget:self action:@selector(autoLoginEnabled) forControlEvents:UIControlEventValueChanged];
    [_enableTouchIDSwitch addTarget:self action:@selector(touchIDEnabled) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma UISwitch validations

-(void)autoLoginEnabled{
    if (_autoLoginSwitch.on==YES) {
        _enableTouchIDSwitch.enabled=NO;
    }else{
    _enableTouchIDSwitch.enabled=YES;
    }
}
-(void)touchIDEnabled{
    if (_enableTouchIDSwitch.on==YES) {
        _autoLoginSwitch.enabled=NO;

    } else {
        _autoLoginSwitch.enabled=YES;

    }
    }

#pragma LoginValidations

-(BOOL)validateFields{
    if ([self.usernameField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"Username Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return  NO;
    }
    else if ([self.passwordField.text isEqualToString:@""]) {
        [LearningMethods showUIAlertMessage:@"Password Cannot be blank" andWithTitle:@"Error" andInView:self.navigationController];
        return  NO;
    }
    else{
    return YES;
    }
}

-(void)validateLogin{
    
    NSString *databasePath;
    sqlite3 *DB;
    NSString *docsDir;
    NSArray *dirPaths;
    
    //Get the Directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the Path to keep the database
    
    databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"PokerDatabase.db"]];
    sqlite3_stmt *statement;
    const char *dbPath = [databasePath UTF8String];
    if (sqlite3_open(dbPath, &DB)==SQLITE_OK) {
        NSString *getDataSQL = [NSString stringWithFormat:@"SELECT Username,Password,FirstName,LastName,EmailID,PhoneNo from Users where Username =\"%@\" LIMIT 1",self.usernameField.text];
        const char *getData_statement = [getDataSQL UTF8String];
        if (sqlite3_prepare_v2(DB, getData_statement, -1, &statement, NULL)==SQLITE_OK)
        {
            _loginUserData = [[NSMutableArray alloc]init];
            while (sqlite3_step(statement)==SQLITE_ROW) {
                
                NSString *userName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *password = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *firstName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                NSString *lastName =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *emailID =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *phoneNo =  [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                
                [_loginUserData addObject:[[UserProfile alloc]initWithUsername:userName andPassword:password andFirstName:firstName andLastName:lastName andEmailId:emailID andPhoneNo:phoneNo]];
               // [_loginUserData addObject:[[SessionsData alloc]initWithName:name andSessionsLocation:location andSessionsDateCreated:dateCreated andSessionID:sessionID]];
                //NSLog(@"this is sessions data %@",_CurrentSessionData);
            }
            
            
            sqlite3_close(DB);
        }
        else{
            NSLog(@"Query not successfull");
        }
    }
    
}

-(void)LoginToApp{
    
    if ([_loginUserData count] ==0 ) {
        [LearningMethods showUIAlertMessage:@"Invalid username or password" andWithTitle:@"Error" andInView:self.navigationController];
    }
    else{
        UserProfile *getLoginUserDate = [_loginUserData objectAtIndex:0];
    if ([getLoginUserDate.Password isEqualToString:_passwordField.text]){
        NSLog(@"Yeppie, i logged in");
    }
    else{
         [LearningMethods showUIAlertMessage:@"Wrong password,please try again" andWithTitle:@"Error" andInView:self.navigationController];
    }
    }
}


-(void)saveUserPreferencesToCoreData{
    
}

- (IBAction)loginButton:(id)sender {
    //[self validateFields];
    //[self validateLogin];
    //[self LoginToApp];
    [self storeUserPreferences];
    [self fetchResults];
    UIStoryboard * homeScreenStoryBoard = [UIStoryboard storyboardWithName:@"HomeScreenStoryBoard" bundle:nil];
    UIViewController *homeViewController = [homeScreenStoryBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [self.navigationController pushViewController:homeViewController animated:YES];

}


/*
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
*/

-(void)storeUserPreferences{
   // NSManagedObjectContext *con = [self managed]
    //NSManagedObjectContext *context = self.managedObjectContext;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *objectToSave = [NSEntityDescription insertNewObjectForEntityForName:@"UserAttributes" inManagedObjectContext:context];
    
    [objectToSave setValue:@"vesnkat" forKey:@"username"];
    if(_autoLoginSwitch.on ==YES){
        [objectToSave setValue:[NSNumber numberWithBool:YES] forKey:@"autoLogin"];
    }else{
    [objectToSave setValue:[NSNumber numberWithBool:NO] forKey:@"autoLogin"];
    }
    if(self.enableTouchIDSwitch.on==YES){
        [objectToSave setValue:[NSNumber numberWithBool:YES] forKey:@"enableTouchID"];
    }else{
        [objectToSave setValue:[NSNumber numberWithBool:NO] forKey:@"enableTouchID"];
    }
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"Yeppie , I learnt core data");
    }
    
}

-(void)fetchResults {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserAttributes" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
  /*  // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"<#key#>"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    */
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"This is empty");
    }
    NSLog(@"This is the row count %lu",(unsigned long)fetchedObjects.count);
    
}

- (IBAction)signUpButton:(id)sender {
}

- (IBAction)helpButton:(id)sender {
    

    
}

@end
