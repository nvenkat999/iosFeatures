//
//  SignUpViewController.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/8/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UITableViewController<UITextViewDelegate,UITextFieldDelegate>

- (id)initWithTextFieldsCollection:(NSArray*)textFieldsCollection;
//@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsCollection;
@property (weak,nonatomic) UITextField *activeTextField;
@property (strong, nonatomic) NSArray *inputFields;

@property (strong, nonatomic) NSArray *inputFieldsDelegates;




@end
