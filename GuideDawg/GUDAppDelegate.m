//
//  GUDAppDelegate.m
//  GuideDawg
//
//  Created by Jeff Kielman on 2014-11-22.
//  Copyright (c) 2014 ___WORKPARTY___. All rights reserved.
//

#import "GUDAppDelegate.h"
#import <RestKit/RestKit.h>
#import "VenueObject.h"






@implementation GUDAppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeUserInterface];
    


    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];

    [[UINavigationBar appearance] setTranslucent:NO];
    
    
    [[UITabBar appearance] setTranslucent:NO];

    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];

    
    
    
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor: [UIColor colorWithWhite:0.0f alpha:0.750f]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:(121.0/255.0) green:(66.0/255.0) blue:(6.0/255.0) alpha:1.0]];


    
     // [[UITabBar appearance] setShadowImage:[UIImage new]];

    [self startStandardLocationServices];

    return YES;
}


-(void) startStandardLocationServices
{
  

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    
    
    
    
    
}





- (void)customizeUserInterface {
    // Customize the nav bar
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.553 green:0.435 blue:0.718 alpha:1.0]];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBarBackground"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // Customize the tab bar
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    
    
    UIImage *tabCompassImage = [[UIImage imageNamed:@"compass"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *tabMapImage = [[UIImage imageNamed:@"map"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *tabListImage = [[UIImage imageNamed:@"list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //UIImage *tabDetailsImage = [[UIImage imageNamed:@"details"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabCompass = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabMap = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabList = [tabBar.items objectAtIndex:2];
    
    //UITabBarItem *tabDetails = [tabBar.items objectAtIndex:3];
    
    tabCompass = [tabCompass initWithTitle:@"" image:tabCompassImage selectedImage:tabCompassImage];
    tabMap = [tabMap initWithTitle:@"" image:tabMapImage selectedImage:tabMapImage];
    tabList = [tabList initWithTitle:@"" image:tabListImage selectedImage:tabListImage];
    //tabDetails = [tabDetails initWithTitle:@"" image:tabDetailsImage selectedImage:tabDetailsImage];
   
   



}





							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
