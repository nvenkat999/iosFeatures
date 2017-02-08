//
//  AppPurchaseViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/28/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface AppPurchaseViewController : UIViewController <SKRequestDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver>
@property (weak, nonatomic) IBOutlet UITextView *productDescription;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;

@property (weak, nonatomic) IBOutlet UIButton *buyProductButton;

@property (strong, nonatomic) SKProduct *product;

@end
