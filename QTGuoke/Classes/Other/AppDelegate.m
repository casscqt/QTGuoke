//
//  AppDelegate.m
//  QTGuoke
//
//  Created by Cass on 15/12/8.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import "AppDelegate.h"
#import "QTGuoKeViewController.h"
#import "QTLeftViewViewController.h"



@interface AppDelegate ()

@property (nonatomic,strong) UINavigationController *navController;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor greenColor];
    
    QTLeftViewViewController *leftController = [[QTLeftViewViewController alloc]init];
    
    IIViewDeckController *deckController = [[IIViewDeckController alloc] initWithCenterViewController:leftController.firstVc leftViewController:leftController rightViewController:nil];
    

    deckController.delegateMode = IIViewDeckDelegateAndSubControllers;
    deckController.leftSize = kViewDeckLeftSize;

    self.window.rootViewController = deckController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
