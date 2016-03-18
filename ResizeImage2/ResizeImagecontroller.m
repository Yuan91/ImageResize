//
//  ResizeImagecontroller.m
//  ResizeImage2
//
//  Created by Mr_du on 16/3/1.
//  Copyright © 2016年 Mr_du. All rights reserved.
//

#import "ResizeImagecontroller.h"

@interface ResizeImagecontroller ()<NSTextFieldDelegate>
{
    NSAlert *_alert;
}
@end

@implementation ResizeImagecontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    _alert = [[NSAlert alloc]init];
    [_alert addButtonWithTitle:@"确定"];
    [_alert setAlertStyle:NSWarningAlertStyle];
    
    self.widthTf.delegate = self;
    self.heightTf.delegate = self;
}

#pragma mark ---NSTextFiledDelegate---
//按下tab 切换输入焦点
- (BOOL)control:(NSControl *)control textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelecto{
    if (commandSelecto == @selector(insertTab:)) {
        if (control == self.widthTf) {
            [self.heightTf becomeFirstResponder];
        }
        else if (control == self.heightTf){
            [self.widthTf becomeFirstResponder];
        }
    }
    return YES;
}

#pragma mark ---输入尺寸----
- (IBAction)buttonClicked:(id)sender {
        CGSize size = CGSizeMake([_widthTf floatValue], [_heightTf floatValue]);
        BOOL isSuccess = [self reSizeImage:size];
    
        _alert.messageText = isSuccess ? @"缩放成功":@"缩放失败";
        [_alert beginSheetModalForWindow:[NSApp mainWindow] completionHandler:nil];
}

#pragma mark---勾选尺寸---
- (IBAction)confirClick:(id)sender {
    NSInteger successCount = 0;
    NSArray *sizeArray = @[NSStringFromSize(CGSizeMake(58, 58)), // 29 @2
                           NSStringFromSize(CGSizeMake(87, 87)), // 29 @3
                           NSStringFromSize(CGSizeMake(80, 80)), // 40 @2
                           NSStringFromSize(CGSizeMake(120, 120)), // 40 @3
                           NSStringFromSize(CGSizeMake(120, 120)), // 60 @2
                           NSStringFromSize(CGSizeMake(180, 180))]; // 60 @3
    NSMutableArray *checkButtonArray = [[NSMutableArray alloc]initWithObjects:self.check0,self.check1,self.check2 ,nil];
    
    for (int i = 0; i < sizeArray.count; i++) {
        NSInteger state = [[checkButtonArray objectAtIndex: i /2 ] state];
        BOOL buttonState = state == NSOnState ? YES:NO;
        if (buttonState) {
            CGSize size = NSSizeFromString(sizeArray[i]);
            BOOL isSuccess = [self reSizeImage:size];
            if(isSuccess) successCount++;
        }
    }
    
    _alert.messageText = [NSString stringWithFormat:@"缩放完成\n成功%ld张\n失败%lu张\n",(long)successCount,sizeArray.count-successCount];
    [_alert beginSheetModalForWindow:[NSApp mainWindow] completionHandler:nil];
}

- (BOOL)reSizeImage:(CGSize)size{
    NSImage *image = [self.dragImage.image resizedImageWithSize:size];
    NSString *imageName = [NSString stringWithFormat:@"%.0f*%.0f.png",size.width,size.height];
    return  [image saveToFile:[self getFilePathWithImageSize:imageName] withType:NSPNGFileType];
}


- (NSString *)getFilePathWithImageSize:(NSString *)sizeString{
    NSString *documentPath = [NSString stringWithFormat:@"%@/Desktop/ResizeImage",NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    NSString *filePath = [documentPath stringByAppendingPathComponent:sizeString];
    return filePath;
}

@end
