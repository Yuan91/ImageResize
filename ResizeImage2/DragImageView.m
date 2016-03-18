//
//  DragImageView.m
//  ResizeImage2
//
//  Created by Mr_du on 16/3/1.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import "DragImageView.h"
#import "NSImage+Resize.h"
@implementation DragImageView

NSString *kPrivateDragUTI = @"com.CCoding.DragNDrop";

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    if (highLight) {
        [NSColor grayColor];
        [NSBezierPath setDefaultLineWidth:5];
        [NSBezierPath strokeRect:dirtyRect];
    }
}

#pragma mark ---NSView---
// 点击鼠标左键时
- (void)mouseDown:(NSEvent *)theEvent {
    
    NSPasteboardItem *pbItem = [NSPasteboardItem new];
    [pbItem setDataProvider:self forTypes:[NSArray arrayWithObjects:NSPasteboardTypeTIFF, NSPasteboardTypePDF, kPrivateDragUTI, nil]];
    NSDraggingItem *dragItem = [[NSDraggingItem alloc] initWithPasteboardWriter:pbItem];
    //设置显示区域坐标
    NSRect draggingRect = self.bounds;
    [dragItem setDraggingFrame:draggingRect contents:[self image]];
    
    NSDraggingSession *draggingSession = [self beginDraggingSessionWithItems:[NSArray arrayWithObject:dragItem] event:theEvent source:self];
    draggingSession.animatesToStartingPositionsOnCancelOrFail = YES;
    draggingSession.draggingFormation = NSDraggingFormationNone;
}


- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

#pragma mark ---NSPasteboardItemDataProvider---
//剪贴板接受数据
- (void)pasteboard:(NSPasteboard *)pasteboard item:(NSPasteboardItem *)item provideDataForType:(NSString *)type{
    
    if ([type compare:NSPasteboardTypeTIFF] == NSOrderedSame) {
        [pasteboard setData:[[self image] TIFFRepresentation] forType:NSPasteboardTypeTIFF];
    } else if ([type compare:NSPasteboardTypePDF] == NSOrderedSame) {
        [pasteboard setData:[self dataWithEPSInsideRect:[self bounds]] forType:NSPasteboardTypePDF];
    }
    
}

#pragma mark ---NSDraggingSource---
// 拖动执行操作
- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context {
    
    switch (context) {
        case NSDraggingContextOutsideApplication:
            return NSDragOperationCopy;
            
        default:
            return NSDragOperationCopy;
            break;
    }
}

#pragma mark---NSDraggingDestination---
//拖动图片进入目标区域时执行
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    
    if ([NSImage canInitWithPasteboard:[sender draggingPasteboard]] && [sender draggingSourceOperationMask] & NSDragOperationCopy) {
        highLight = YES;
        [self setNeedsDisplay: YES];
        [sender enumerateDraggingItemsWithOptions:NSDraggingItemEnumerationConcurrent forView:self classes:[NSArray arrayWithObject:[NSPasteboardItem class]] searchOptions:nil usingBlock:^(NSDraggingItem *draggingItem, NSInteger idx, BOOL *stop) {
            
            if (![[[draggingItem item] types] containsObject:kPrivateDragUTI]) {
                *stop = YES;
            } else {
                [draggingItem setDraggingFrame:self.bounds contents:[[[draggingItem imageComponents] objectAtIndex:0] contents]];
            }
        }];
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

// 拖动图片退出 目标区域时
- (void)draggingExited:(id<NSDraggingInfo>)sender {
    highLight = NO;
    [self setNeedsDisplay:YES];
}

//释放图片时，接收器是否可以接收数据
- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
    highLight = NO;
    [self setNeedsDisplay:YES];
    return  [NSImage canInitWithPasteboard:[sender draggingPasteboard]];
}

//指示接收器 接收数据
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    
    if ([sender draggingSource] != self) {
        if ([NSImage canInitWithPasteboard:[sender draggingPasteboard]]) {
            //从剪贴板获取图片数据
            NSImage *newImage = [[NSImage alloc] initWithPasteboard:[sender draggingPasteboard]];
            [self setImage:newImage];
        }
    }
    
    return YES;
}


@end
