//
//  NSImage+Resize.m
//  ImageResize
//
//  Created by Mr_du on 16/2/29.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import "NSImage+Resize.h"

@implementation NSImage (Resize)

- (NSImage *)resizedImageWithSize:(NSSize)newSize
{
    NSBitmapImageRep *rep = (NSBitmapImageRep *)self.representations.firstObject;
    rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                  pixelsWide:newSize.width
                                                  pixelsHigh:newSize.height
                                               bitsPerSample:rep.bitsPerSample
                                             samplesPerPixel:rep.samplesPerPixel
                                                    hasAlpha:rep.hasAlpha
                                                    isPlanar:rep.isPlanar
                                              colorSpaceName:rep.colorSpaceName
                                                 bytesPerRow:0
                                                bitsPerPixel:0];
    rep.size = newSize;
    
    NSGraphicsContext *context = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
    if (!context) {
        rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                      pixelsWide:newSize.width
                                                      pixelsHigh:newSize.height
                                                   bitsPerSample:8
                                                 samplesPerPixel:4
                                                        hasAlpha:YES
                                                        isPlanar:NO
                                                  colorSpaceName:NSCalibratedRGBColorSpace
                                                     bytesPerRow:0
                                                    bitsPerPixel:0];
        rep.size = newSize;
        context = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
    }
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:context];
    [self drawInRect:NSMakeRect(0, 0, newSize.width, newSize.height)];
    [NSGraphicsContext restoreGraphicsState];
    
    return [[NSImage alloc] initWithData:[rep representationUsingType:NSPNGFileType
                                                           properties:nil]];
}

- (BOOL)saveToFile:(NSString *)filePath withType:(NSBitmapImageFileType)type
{
    NSData *data = nil;
    if (type == NSTIFFFileType) {
        data = self.TIFFRepresentation;
    }
    else {
        NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:self.TIFFRepresentation];
        data = [rep representationUsingType:type
                                 properties:nil];
    }
    return [data writeToFile:filePath
                  atomically:NO];
}


@end
