//
//  PaymentViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "PaymentViewController.h"
#import <Braintree/Braintree.h>
#import <AFNetworking/AFNetworking.h>
#import "StadiumsViewController.h"

@interface PaymentViewController ()

@property NSString *clientToken;
//@property Braintree *braintree;
@property NSString *nonce;

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:@"http://54.69.129.75/braintree_server/laravel/public/index.php/getToken"
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              //store resulting token to user's settings
              NSLog(@"clientToken response: %@", responseObject[@"result"]);
              self.clientToken = responseObject[@"result"];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // Handle failure communicating with your server
              NSLog(@"clientToken error: %@", error.description);
          }];
}

- (void)didReceiveMemoryWarning {    [super didReceiveMemoryWarning];    // Dispose of any resources that can be recreated.
}

- (IBAction)paymentButton:(UIButton *)sender {
    // Create a Braintree with the client token
    Braintree *braintree = [Braintree braintreeWithClientToken:self.clientToken];
    // Create a BTDropInViewController
    BTDropInViewController *dropInViewController = [braintree dropInViewControllerWithDelegate:self];
    // This is where you might want to customize your Drop in. (See below.)
    
    // The way you present your BTDropInViewController instance is up to you.
    // In this example, we wrap it in a new, modally presented navigation controller:
    dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                          target:self
                                                                                                          action:@selector(userDidCancelPayment)];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}

- (void)userDidCancelPayment {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod {
    self.nonce = paymentMethod.nonce;
    [self createCustomer:self.nonce]; // Send payment method nonce to your server
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createCustomer:(NSString *)nonce {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:@"http://54.69.129.75/braintree_server/laravel/public/index.php/createCustomer"
      parameters:@{ @"nonce": nonce}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //store resulting token to user's settings
             NSLog(@"response object: %@", operation.responseString);
             
             // Save the customer information
             // parse out the seperate customer information fields
             NSDictionary *result = responseObject[@"result"];
             
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             [defaults setObject:result forKey:@"customer"];
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // Handle failure communicating with your server
             NSLog(@"%@\n\n%@",error.description, error.debugDescription);
         }];
    
    [self performSegueWithIdentifier:@"segueToStadiums" sender:self];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

 }

@end
