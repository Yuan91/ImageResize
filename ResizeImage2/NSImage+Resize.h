//
//  NSImage+Resize.h
//  ImageResize
//
//  Created by Mr_du on 16/2/29.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Resize)

- (NSImage *)resizedImageWithSize:(NSSize)size;

- (BOOL)saveToFile:(NSString *)filePath withType:(NSBitmapImageFileType)type;

@end
