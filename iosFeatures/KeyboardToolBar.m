//
//  KeyboardToolBar.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/7/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "KeyboardToolBar.h"
#import "LoginViewController.h"
#import <usernotifications/usernotifications.h>

@interface KeyboardToolBar () <UITextFieldDelegate>




@end


@implementation KeyboardToolBar 

//@synthesize activeTextField;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(KeyboardToolBar *)keyBoardToolBar{
    KeyboardToolBar *toolbar = [[KeyboardToolBar alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)];
    return toolbar;
}


-(id)initWithFrame:(CGRect)frame{
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
    //myToolBar.frame= (CGRect){CGPointZero, [myToolBar sizeThatFits:CGSizeZero]};
    //[self setActiveTextField:activeTextField];
    //[activeTextField setInputAccessoryView:myToolBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    return  self;
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
        textField.inputAccessoryView = self;
    }
    self.inputFieldsDelegates = delegates;
}




+ (void)setInputAccessoryViewForTextField:(UITextField *)activeTextField{
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
    //[self setActiveTextField:activeTextField];
    [activeTextField setInputAccessoryView:myToolBar];
    
    
}



-(void)dismissKeyboard:(id)sender{
   // [self.tex endEditing:YES];
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
            if (indexOfActiveTextFiled > 0) {
                [self.inputFields[indexOfActiveTextFiled + 1] becomeFirstResponder];
            }
            break;
    }
}


    
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    CGRect keyboardEndFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardFrame = [self.mainScrollView.superview convertRect:keyboardEndFrame fromView:nil];
    UIViewAnimationCurve curve = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
    UIViewAnimationOptions options = (curve << 16) | UIViewAnimationOptionBeginFromCurrentState;
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = self.mainScrollView.frame;
    newFrame.size.height = self.keyboardFrame.origin.y - newFrame.origin.y;
    
    [UIView animateWithDuration:duration delay:0.0 options:options animations:^{
        self.mainScrollView.frame = newFrame;
    } completion:^(BOOL finished) {
        NSUInteger indexOfActiveTextFiled = [self.inputFields indexOfObjectPassingTest:^BOOL(UITextField *textField, NSUInteger idx, BOOL* stop) {
            return textField.isFirstResponder;
        }];
        if (indexOfActiveTextFiled != NSNotFound) {
            UITextField *textField = self.inputFields[indexOfActiveTextFiled];
            CGRect frameToScroll = [self.mainScrollView convertRect:textField.frame fromView:textField.superview];
            [self scrollRectToVisible:frameToScroll animated:YES];
        }
    }];
}


- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated {
    
    if (rect.size.height > self.keyboardFrame.origin.y) {
        rect.size.height = self.keyboardFrame.origin.y;
    }
    [self.mainScrollView scrollRectToVisible:rect animated:animated];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect frameToScroll = [self.mainScrollView convertRect:textView.frame fromView:textView.superview];
    [self scrollRectToVisible:frameToScroll animated:YES];
    
    NSUInteger index = [self.inputFields indexOfObject:textView];
    if ([self.inputFieldsDelegates[index] respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.inputFieldsDelegates[index] textViewDidBeginEditing:textView];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    CGRect frameToScroll = [self.mainScrollView convertRect:textField.frame fromView:textField.superview];
    [self scrollRectToVisible:frameToScroll animated:YES];
    
    NSUInteger index = [self.inputFields indexOfObject:textField];
 /* if ([self.inputFieldsDelegates[index] respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.inputFieldsDelegates[index] textFieldDidBeginEditing:textField];
    } */
}

@end
