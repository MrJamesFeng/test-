//
//  ViewController.m
//  动态下载字体
//
//  Created by LDY on 17/3/19.
//  Copyright © 2017年 LDY. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"检查字体" style:UIBarButtonItemStylePlain target:self action:@selector(checkDownFont)];
    
}

-(void)checkDownFont{
    NSString *fontName = @"DFWaWaSC-W5";//娃娃体
    UIFont *font = [UIFont fontWithName:fontName size:14];
    if ([font.fontName compare:fontName] == NSOrderedSame||[font.familyName compare:fontName] == NSOrderedSame) {
        NSLog(@"字体存在");
    }else{
        NSLog(@"字体不存在");
    }
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName,kCTFontNameAttribute, nil];
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    NSMutableArray *descs = [NSMutableArray array];
    [descs addObject: (__bridge id)desc];
    CFRelease(desc);
    __block BOOL errorDuringDownload = NO;
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler((__bridge CFArrayRef)descs, NULL, ^bool(CTFontDescriptorMatchingState state, CFDictionaryRef  _Nonnull progressParameter) {
        double progress = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue] ;
        if (state == kCTFontDescriptorMatchingDidBegin) {
            NSLog(@"开始");
        }
        if (state ==  kCTFontDescriptorMatchingDidFinish) {
            NSLog(@"完成");
        }
        if (state ==  kCTFontDescriptorMatchingDidFailWithError) {
            NSLog(@"出错");
        }
        NSLog(@"progress=%f",progress);
    
        
        return  YES;
    });
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
