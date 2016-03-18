//
//  ResizeImagecontroller.h
//  ResizeImage2
//
//  Created by Mr_du on 16/3/1.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DragImageView.h"
#import "NSImage+Resize.h"
@interface ResizeImagecontroller : NSViewController

@property (weak) IBOutlet NSTextField *widthTf;
@property (weak) IBOutlet NSTextField *heightTf;
@property (weak) IBOutlet DragImageView *dragImage;

@property (weak) IBOutlet NSButton *check0;
@property (weak) IBOutlet NSButton *check1;
@property (weak) IBOutlet NSButton *check2;


@end
