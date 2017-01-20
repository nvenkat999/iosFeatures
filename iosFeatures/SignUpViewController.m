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
#import <usernotifications/usernotifications.h>
#import <UIKit/UIKit.h>

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
    //[self findAllTextFieldsInView:self.view];
    self.navigationController.navigationBarHidden=NO;
    [self setInputFields:@[self.UsernameField,self.passwordField,self.confirmPasswordField,self.emailField,self.firstNameField,self.lastNameField,self.phoneNoField]];
    //[self setInputFields:<#(NSArray *)#>]
    
    _UsernameField.delegate=self;
    _passwordField.delegate=self;
    [LearningMethods dismissKeyboardWhenPressed:self.view];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UIkeyBoardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UIkeyBoardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Validation and saving

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
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark Keypad Toolbar

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
        textField.inputAccessoryView = self;
    }
    self.inputFieldsDelegates = delegates;
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"text view editing did start");
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"text view editing ended");
}

-(void)createToolBar{
   // IBOutlet UIToolbar *toolBar;
    //toolbar.tint
}

/*
-(void)UIkeyBoardWillShowNotification:(NSNotification *)notification{
    NSLog(@"Keyboard shown");
    UIViewAnimationCurve animationCurve = [[[notification userInfo]valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationTime = [[[notification userInfo]valueForKey:UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:animationCurve];
    [UIView setAnimationDuration:animationTime];
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
    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height- keyboardBounds.size.height , myToolBar.frame.size.width, myToolBar.frame.size.height)];
    //return myToolBar;
    [self.view addSubview:myToolBar];
    myToolBar.alpha = 1.0;
    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height- keyboardBounds.size.height , myToolBar.frame.size.width, myToolBar.frame.size.height)];
    [UIView commitAnimations];
    
}
*/
 
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

/*
-(id)initWithTextFieldsCollection:(NSArray*)textFieldsCollection {
    
    
    // This is used to initailize the InputAccessoryView class.
    
    // It takes a text field collection from the main view and sorts it according to the y-axis coordinates.
    
    self = [super init];
    
    if(self) {
        
        [self setTextFieldsCollection:[textFieldsCollection sortedArrayUsingComparator:^NSComparisonResult(id txtField1, id txtField2) {
            
            if ([txtField1 frame].origin.y < [txtField2 frame].origin.y)
                
                return NSOrderedAscending;
            
            else if ([txtField1 frame].origin.y > [txtField2 frame].origin.y)
                
                return NSOrderedDescending;
            
            else return NSOrderedSame; }]];
        
    }
    
    return self;
    
    
}


*/


- (void)setActiveTextField:(UITextField *)txtActiveField {
    _activeTextField = txtActiveField;
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

//- (void) previousNextButtons:(UISegmentedControl *)sender {
//    NSInteger previousOrNext = sender.selectedSegmentIndex == 0 ? -1 : +1;
//    
//    
//    if (self.txtActiveField) {
//        
//        int positionOfActiveTextField = [[self textFieldsCollection] indexOfObject:[self txtActiveField]];
//        
//        if((previousOrNext == -1 && positionOfActiveTextField == 0) // Checks that previous button has been pressed on first textfield.
//           
//           || (previousOrNext == 1 && positionOfActiveTextField == ([[self textFieldsCollection] count] - 1))) // Checks that next button has been pressed on last textfield.
//            
//            return;
//        
//        
//        // Making the next textfield (after the currently selected textfield) as the first responder.
//        
//        [[[self textFieldsCollection] objectAtIndex:(positionOfActiveTextField + previousOrNext)] becomeFirstResponder];
//        
//    }else {
//        
//        NSLog(@"inconsistent previousNextOfAccessoryViewClicked");
//        
//    }
//    }

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
    [previousNextControl addTarget:self action:@selector(previosuNextButtons:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    UIBarButtonItem *controlButton = [[UIBarButtonItem alloc]initWithCustomView:previousNextControl];
    [myToolBar setItems:@[controlButton,space,doneButton]];
    [myToolBar setFrame:CGRectMake(0.0f, self.view.frame.size.height-myToolBar.frame.size.height, myToolBar.frame.size.width, myToolBar.frame.size.height)];
    return myToolBar;
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


@end
