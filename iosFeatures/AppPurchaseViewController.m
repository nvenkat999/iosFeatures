//
//  AppPurchaseViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/28/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "AppPurchaseViewController.h"

@interface AppPurchaseViewController ()<SKPaymentTransactionObserver>

@end

@implementation AppPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if([SKPaymentQueue canMakePayments]){
        
    NSString *productString = @"venkats.iosFeatures.testItem1";
    SKProductsRequest *request= [[SKProductsRequest alloc]initWithProductIdentifiers:[NSSet setWithObject:productString]];
    request.delegate = self;
    [request start];
    
    }else{
        NSLog(@"Cannot make payment, please reset your setting");
    }
    // Do any additional setup after loading the view.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buyProductAction:(id)sender {
    
    [[SKPaymentQueue defaultQueue]addTransactionObserver:self];
    SKPayment *payment = [SKPayment paymentWithProduct:_product];
    [[SKPaymentQueue defaultQueue]addPayment:payment];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
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
                break;
            case SKPaymentTransactionStateFailed:
                [[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction failed");
                [[SKPaymentQueue defaultQueue]removeTransactionObserver:self];
                break;
            case SKPaymentTransactionStateDeferred:
                //[[SKPaymentQueue defaultQueue]finishTransaction:transaction];
                NSLog(@"Transaction deferred");
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
}

-(void)itemPurchased{
    NSLog(@"Transaction sucessful block");
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
