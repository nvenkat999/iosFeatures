//
//  TextFieldObject.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/6/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "TextFieldObject.h"

@implementation TextFieldObject

-(id)initWithTextFieldsCollection:(NSArray*)textFieldsCollection {
    
    
    // This is used to initailize the InputAccessoryView class.
    
    // It takes a text field collection from the main view and sorts it according to the y-axis coordinates.
    
    self = [super init];
    
    if(self) {
        NSArray * setTextFieldsCollection;
        
        [self setTextFieldsCollection:[textFieldsCollection sortedArrayUsingComparator:^NSComparisonResult(id txtField1, id txtField2) {
            
            if ([txtField1 frame].origin.y < [txtField2 frame].origin.y)
                
                return NSOrderedAscending;
            
            else if ([txtField1 frame].origin.y > [txtField2 frame].origin.y)
                
                return NSOrderedDescending;
            
            else return NSOrderedSame; }]];
        
    }
    
    return self;
    
    
}

- (void)setInputAccessoryViewForTextField:(UITextField *)activeTextField {
    
    
    if(!self.toolbar) {
        
        // Creating a toolbar object to be used as accessory view.
        
        self.toolbar = [[UIToolbar alloc] init];
        
        self.toolbar.tintColor = nil;
        
        self.toolbar.barStyle = UIBarStyleBlack;
        
        self.toolbar.translucent = YES;
        
        self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[ TOOLBAR_PREVIOUS_BUTTON_TITLE, TOOLBAR_NEXT_BUTTON_TITLE]];
        
        [segmentedControl addTarget:self action:@selector(previousNextOfAccessoryViewClicked:) forControlEvents:UIControlEventValueChanged];
        
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        
        segmentedControl.momentary = YES;
        
        
        // Creating the bar button for Previous/Next/Done.
        
        UIBarButtonItem *segmentedControlBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
        
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneOfAccessoryViewClicked)];
        
        
        // Adding the buttons to the toolbar.
        
        if (IS_IPHONE()) {
            
            self.toolbar.items = @[ segmentedControlBarButtonItem, flexibleSpace, doneButton];
            
        }else {
            
            //done button is not required on iPad for closing the keyboard
            
            self.toolbar.items = @[ segmentedControlBarButtonItem, flexibleSpace];
            
        }
        
        
        self.toolbar.frame = (CGRect){CGPointZero, [self.toolbar sizeThatFits:CGSizeZero]};
        
    }
    
    
    // Setting the currently selected textfield as active textfield.
    
    [self setTxtActiveField:activeTextField];
    
    [activeTextField setInputAccessoryView:self.toolbar];
    
}


@end
