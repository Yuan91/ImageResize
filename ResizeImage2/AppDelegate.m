//
//  AppDelegate.m
//  ResizeImage2
//
//  Created by Mr_du on 16/3/1.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import "AppDelegate.h"
#import "ResizeImagecontroller.h"
@interface AppDelegate ()

@property (nonatomic,strong) ResizeImagecontroller *reSizeVC;
@property (weak) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    self.reSizeVC = [[ResizeImagecontroller alloc]init];
    [self.window.contentView addSubview:self.reSizeVC.view];
    self.reSizeVC.view.frame = ((NSView *)self.window.contentView).bounds;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
