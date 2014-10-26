//
//  StadiumsViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "StadiumsViewController.h"
#import "StadiumDetailsViewController.h"

@interface StadiumsViewController ()

@property NSArray *stadiums;
@property NSDictionary *currentStadium;

@end

@implementation StadiumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSDictionary *stadium1 = @{
                     @"stadium": @"sample stadium 1",
                     @"logo": @"",
                     @"price": @"$25.00",
                     @"qr code": @"1001012023034",
    };
    
    NSDictionary *stadium2 = @{
                    @"stadium":@"sample stadium 2",
                    @"logo":@"",
                    @"price":@"$40.00",
                    @"qr code":@"1001012023034",
    };
    
    self.stadiums = [[NSArray alloc] initWithObjects:stadium1, stadium2, nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickView datasource and delegate method implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.stadiums.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowString = [NSString stringWithFormat:@"%@", [[self.stadiums objectAtIndex:row] objectForKey:@"stadium"]];
    return rowString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentStadium = self.stadiums[row];
    [self performSegueWithIdentifier:@"segueToStadiumDetails" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StadiumDetailsViewController *controller = segue.destinationViewController;
    controller.stadiumName = [self.currentStadium objectForKey:@"stadium"];
    controller.logo = [self.currentStadium objectForKey:@"logo"];
    controller.price = [self.currentStadium objectForKey:@"price"];
    controller.qrCode = [self.currentStadium objectForKey:@"qr code"];
}
/*
#pragma mark - Private instance methods
- (CIImage *)createQRForString:(NSString *)qrString
{
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    
    // Send the image back
    return qrFilter.outputImage;
}
*/
@end
