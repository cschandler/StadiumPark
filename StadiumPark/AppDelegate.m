//
//  AppDelegate.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "AppDelegate.h"
#import <Braintree/Braintree.h>
#import "AFNetworkActivityLogger.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Only for HTTP debugging; comment for production
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    
    // Required for braintree infrastructure
    [Braintree setReturnURLScheme:@"Flow-Enterprises--LLC.StadiumPark.payment"];
    
    // Determine initial ViewController based on whether customer information preexists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];
    NSString *token2 = [defaults objectForKey:@"token2"];
    NSLog(@"tokenStr: %@", token);
    NSLog(@"tokenStr2: %@", token2);
    // success will be changed later to more specific info when we get token working
    Boolean customerExists = !(token == (id)[NSNull null] || token.length == 0);//[token boolValue];
    NSLog(@"bool: %@", customerExists? @"true":@"false");
    NSString *viewControllerId  = (customerExists)? @"StadiumNavigationController" : @"SignUpViewController";
    NSLog(@"vcid: %@", viewControllerId);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *initialViewController = [storyboard instantiateViewControllerWithIdentifier:viewControllerId];
    self.window.rootViewController = initialViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [Braintree handleOpenURL:url sourceApplication:sourceApplication];
    
}

@end
