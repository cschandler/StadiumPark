//
//  PaymentViewController.h
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Braintree/Braintree.h>

@interface PaymentViewController : UIViewController <BTDropInViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *paymentButton;

- (IBAction)paymentButton:(UIButton *)sender;

- (void)userDidCancelPayment;
- (void)createCustomer:(NSString *)nonce;

@end
