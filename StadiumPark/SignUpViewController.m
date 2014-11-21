//
//  SignUpViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 11/20/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "SignUpViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface SignUpViewController ()

-(void)displayAlert:(NSString *)alertMessage;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueTapped:(UIButton *)sender {
    // AFNetworking call
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:@"http://54.69.129.75/braintree_server/laravel/public/index.php/addUser"
       parameters:@{ @"name": self.nameTextField.text, @"email": self.emailTextField.text}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSLog(@"response: %@", operation.responseString);
              NSDictionary *response = responseObject[0];
              NSString *responseString = response[@"result"];
              
              if ([responseString  isEqual: @"success"]) {
                  // segue
                  [self performSegueWithIdentifier:@"segueToPaymentView" sender:self];
                  
              } else if ([responseString  isEqual: @"application failure"]) {
                  // display alert containing failure
                  [self displayAlert:@"Application Failure"];
                  
              }
              
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              // Handle failure communicating with your server
              NSLog(@"%@\n\n%@",error.description, error.debugDescription);
          }];
}

- (void)displayAlert:(NSString *)alertMessage {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                           message:alertMessage
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
