//
//  KeyboardToolBar.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/7/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardToolBar : UIToolbar

@property (strong,nonatomic) NSMutableArray * inputFields;
@property (strong, nonatomic) NSArray *inputFieldsDelegates;
@property (weak,nonatomic) UITextField *activeTextField;
+ (void)setInputAccessoryViewForTextField:(UITextField *)activeTextField;
//- (void)setInputFields:(NSArray *)inputFields;
- (void)setInputFields:(NSMutableArray *)inputFields;
@property (assign, nonatomic) CGRect keyboardFrame;
@property (strong, nonatomic) UIScrollView *mainScrollView;

+(KeyboardToolBar *)keyBoardToolBar;
@end
