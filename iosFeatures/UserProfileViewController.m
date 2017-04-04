//
//  UserProfileViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "UserProfileViewController.h"
#import "SqlLiteDatabaseMethods.h"
#import "LearningMethods.h"
#import <usernotifications/usernotifications.h>
#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "AppDelegate.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *UsernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNoField;
- (IBAction)saveButton:(id)sender;
- (IBAction)cancelButton:(id)sender;
- (IBAction)doneButton:(id)sender;

@end


@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    
    [self setInputFields:@[self.UsernameField,self.passwordField,self.confirmPasswordField,self.emailField,self.firstNameField,self.lastNameField,self.phoneNoField]];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIkeyBoardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [self getUserData];
    [self setValuesInTextFields];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getUserData{
    [self fetchResults];
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
        //NSLog(@"This is username %@",usernameFromCoreData);
        //NSString *getDataSQL = [NSString stringWithFormat:@"SELECT Username,Password,FirstName,LastName,EmailID,PhoneNo from Users where Username =\"%@\" LIMIT 1",_usernameString];
         NSString *getDataSQL = [NSString stringWithFormat:@"SELECT Username,Password,FirstName,LastName,EmailID,PhoneNo from Users where Username ='exa1' LIMIT 1"];
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

-(void)setValuesInTextFields{
    NSMutableArray *userData = [_loginUserData objectAtIndex:0];
    self.UsernameField.text = [userData valueForKey:@"Username"];
    
    
    self.passwordField.text = [userData valueForKey:@"Password"];
    self.confirmPasswordField.text = [userData valueForKey:@"Password"];
    self.firstNameField.text = [userData valueForKey:@"FirstName"];
    self.lastNameField.text = [userData valueForKey:@"LastName"];
    self.emailField.text = [userData valueForKey:@"EmailId"];
    self.phoneNoField.text = [userData valueForKey:@"PhoneNo"];
    
}


- (void)setInputFields:(NSArray *)inputFields {
    
    _inputFields = inputFields;
    NSMutableArray *delegates = [NSMutableArray array];
    for (UITextField *textField in inputFields) {
        if (textField.delegate && textField.delegate != self) {
            [delegates addObject:textField.delegate];
        } else {
            [delegates addObject:[NSNull null]];
        }
        textField.delegate = self;
        textField.inputAccessoryView = self.view;
    }
    self.inputFieldsDelegates = delegates;
}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    if([self validateFields]){
        
        NSString * sqlStatement = [NSString stringWithFormat:@"Update Users  Set Password = \"%@\", FirstName = \"%@\", LastName = \"%@\", PhoneNo = \"%@\", EmailID = \"%@\" where Username = \"%@\" " ,self.passwordField.text, self.firstNameField.text, self.lastNameField.text, self.phoneNoField.text, self.emailField.text, _usernameString];
        [SqlLiteDatabaseMethods InsertData:sqlStatement andSuccessMessage:@"insert data successfull" andFailureMessage:@"Did not insert data"];
        //[self.navigationController popViewControllerAnimated:YES];
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert!" message:@"User details updated" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:Nil];
    }
    
    
}

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

-(void)UIkeyBoardWillHideNotification:(NSNotification *)notification{
    NSLog(@"Keyboard Hided");
    UIViewAnimationCurve animationCurve = [[[notification userInfo]valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationTime = [[[notification userInfo]valueForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationTime];
    UIToolbar *myToolBar = [[UIToolbar alloc]init];
    myToolBar.alpha = 0.0;
    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height- keyboardBounds.size.height , myToolBar.frame.size.width, myToolBar.frame.size.height)];
    [UIView commitAnimations];
    
    
}

- (void)setInputAccessoryViewForTextField:(UITextField *)activeTextField{
    UIToolbar *myToolBar = [[UIToolbar alloc]init];
    [myToolBar setBarStyle:UIBarStyleDefault];
    [myToolBar setTintColor:[UIColor blueColor]];
    [myToolBar sizeToFit];
    [myToolBar setTranslucent:YES];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    UISegmentedControl *previousNextControl =[[UISegmentedControl alloc]initWithItems:@[@"previos",@"next"]];
    [previousNextControl addTarget:self action:@selector(previousNextButtons:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *controlButton = [[UIBarButtonItem alloc]initWithCustomView:previousNextControl];
    [myToolBar setItems:@[controlButton,space,doneButton]];
    //    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height- keyboardBounds.size.height , myToolBar.frame.size.width, myToolBar.frame.size.height)];
    //return myToolBar;
    
    //myToolBar.alpha = 1.0;
    myToolBar.frame= (CGRect){CGPointZero, [myToolBar sizeThatFits:CGSizeZero]};
    
    [self setActiveTextField:activeTextField];
    [activeTextField setInputAccessoryView:myToolBar];
    
    
}

-(void) previousField:(id)sender{
    if ([_passwordField isFirstResponder]) {
        [_UsernameField becomeFirstResponder];
    }
    else if([_UsernameField isFirstResponder]){
        [_passwordField becomeFirstResponder];
        
    }
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field edidting begin");
    _activeTextField = textField;
    [self setInputAccessoryViewForTextField:textField];
    
}

-(NSArray*)findAllTextFieldsInView:(UIView *)view{
    NSMutableArray* textfieldarray = [[NSMutableArray alloc] init];
    for(id x in [view subviews]){
        if([x isKindOfClass:[UITableViewCell class]]){
            [textfieldarray addObject:x];
        }
        if([x respondsToSelector:@selector(subviews)]){
            // if it has subviews, loop through those, too
            [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
            NSLog(@"This is the view %@",x);
            if([x respondsToSelector:@selector(subviews)]){
                
                [textfieldarray addObjectsFromArray:[self findAllTextFieldsInView:x]];
            }
        }
        NSLog(@"This is object %lu",(unsigned long)textfieldarray.count);
        
    }
    //NSLog(@"send field info %@",textfieldarray);
    
    return textfieldarray;
}


-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(UIToolbar *)keyBoardToolBar{
    
    UIToolbar *myToolBar = [[UIToolbar alloc]init];
    [myToolBar setBarStyle:UIBarStyleDefault];
    [myToolBar setTintColor:[UIColor blueColor]];
    [myToolBar sizeToFit];
    [myToolBar setTranslucent:YES];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    UISegmentedControl *previousNextControl =[[UISegmentedControl alloc]initWithItems:@[@"previos",@"next"]];
    [previousNextControl addTarget:self action:@selector(previousNextButtons:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *controlButton = [[UIBarButtonItem alloc]initWithCustomView:previousNextControl];
    [myToolBar setItems:@[controlButton,space,doneButton]];
    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height, myToolBar.frame.size.width, myToolBar.frame.size.height)];
    return myToolBar;
}

-(void)fetchResults {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserAttributes" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"limit=1"];
    //[fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    [fetchRequest setFetchLimit:1];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastLoggedIn"
                                                                   ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count] == 0) {
        NSLog(@"Fetch Object is empty");
    }else{
        
        NSManagedObject *fetchedResult = [fetchedObjects objectAtIndex:0];
        //NSString *const usernameFromCoreData = [fetchedResult valueForKey:@"username"];
        _usernameString= [fetchedResult valueForKey:@"username"];
    }
    
}


-(void) previousNextButtons:(id)sender{
    NSUInteger indexOfActiveTextFiled = [self.inputFields indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
        return textField.isFirstResponder;
    }];
    switch([(UISegmentedControl *)sender selectedSegmentIndex]){
        case 0:
            if (indexOfActiveTextFiled > 0) {
                [self.inputFields[indexOfActiveTextFiled - 1] becomeFirstResponder];
            }
            break;
        case 1:
            if (indexOfActiveTextFiled < self.inputFields.count-1) {
                [self.inputFields[indexOfActiveTextFiled + 1] becomeFirstResponder];
            }
            break;
    }
}

@end
