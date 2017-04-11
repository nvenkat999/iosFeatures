//
//  TextFieldObject.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/6/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIkit/Uikit.h>

@interface TextFieldObject : NSObject<UITextViewDelegate,UITextFieldDelegate>

- (void)setInputAccessoryViewForTextField:(UITextField *)activeTextField;

- (id)initWithTextFieldsCollection:(NSArray*)textFieldsCollection;

@end
