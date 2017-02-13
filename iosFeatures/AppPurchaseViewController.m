//
//  AppPurchaseViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/28/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "AppPurchaseViewController.h"
#import "MBProgressHUD.h"
#import "LearningMethods.h"

@interface AppPurchaseViewController ()<SKPaymentTransactionObserver>

@end

 MBProgressHUD *hud;

@implementation AppPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
        if([SKPaymentQueue canMakePayments]){
            
            NSString *productString = @"venkats.iosFeatures.testItem1";
            SKProductsRequest *request= [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productString]];
            request.delegate = self;
             hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            [request start];
             });
        }else{
            NSLog(@"Cannot make payment, please reset your setting");
        }

}

-(void)viewWillAppear:(BOOL)animated{
    
    self.productDescription.alpha = 0;
    self.productTitle.alpha = 0;
    self.buyProductButton.alpha = 0;
    self.productImage.alpha = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buyProductAction:(id)sender {
    
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Thank you. This is a free app and donation is not required, but if u still wish to continue, click on Donate button otherwise cancel" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
        
    }];
    UIAlertAction *donateAction = [UIAlertAction actionWithTitle:@"Donate" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            sleep(2);
            [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
            SKPayment *payment = [SKPayment paymentWithProduct:_product];
            [[SKPaymentQueue defaultQueue]addPayment:payment];
        });
        
    }];
    [alertView addAction:donateAction];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
    
}


-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
        self.productDescription.alpha = 1;
        self.productTitle.alpha = 1;
        self.buyProductButton.alpha = 1;
        self.productImage.alpha = 1;
    });
    NSArray *productsArray = response.products;
    if (productsArray.count != 0) {
        _product = productsArray[0];
        _productTitle.text = _product.localizedTitle;
        _productDescription.text = _product.localizedDescription;
         NSNumber *price=_product.price;
        NSLog(@"This is price %@",price);
        NSNumber *localPrice = _product.price;
        NSLog(@"This is price %@",localPrice);
        
    }else{
        NSLog(@"No products available");
    }
}


-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self itemPurchased];
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction success");
                [self showUIAlertMessage:@"Transaction successfull, Thanks for donating" andWithTitle:@"Transaction Alert"];
                break;
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction failed");
                [[SKPaymentQueue defaultQueue]removeTransactionObserver:self];
                [self showUIAlertMessage:@"Transaction failed, please try again" andWithTitle:@"Transaction Alert"];
                break;
            case SKPaymentTransactionStateDeferred:
                //[[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction deferred");
                [self showUIAlertMessage:@"Transaction failed, please try again" andWithTitle:@"Transaction Alert"];
                break;
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction restored");
                break;
            case SKPaymentTransactionStatePurchasing:
                //NSLog(@"Transaction purchasing");
                break;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}

-(void)itemPurchased{
    NSLog(@"Transaction sucessful block");
}


-(void)showUIAlertMessage:(NSString *)message andWithTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:Nil];
}


//Need to implement Restore fucntionality
// First set restore buttona nd method to restore
// then productquesue restore completed method

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
