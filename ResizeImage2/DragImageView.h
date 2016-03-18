//
//  DragImageView.h
//  ResizeImage2
//
//  Created by Mr_du on 16/3/1.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DragImageView : NSImageView<NSDraggingSource,NSDraggingDestination,NSPasteboardItemDataProvider>
{
    BOOL highLight;
}

@end
