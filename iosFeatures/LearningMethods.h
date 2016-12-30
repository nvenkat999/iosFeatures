//
//  LearningMethods.h
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/7/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearningMethods : UIViewController<UIGestureRecognizerDelegate>

+(void)dismissKeyboardWhenPressed:(UIView *)sampleView;
+(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title andInView:(UIViewController *)presentView;

@end
