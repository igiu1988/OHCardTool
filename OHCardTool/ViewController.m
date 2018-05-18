//
//  ViewController.m
//  OHCardTool
//
//  Created by wangyang on 2018/5/16.
//  Copyright © 2018年 OHCard. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    __weak IBOutlet NSTextField *domain;
    __weak IBOutlet NSTextField *pathTextField;

    __unsafe_unretained IBOutlet NSTextView *inputTextView;
    __unsafe_unretained IBOutlet NSTextView *resultTextView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    domain.stringValue = @"http://p7kj39eo3.bkt.clouddn.com/";
    pathTextField.stringValue = @"renxiangka";
    resultTextView.automaticQuoteSubstitutionEnabled = NO;
    resultTextView.font = [NSFont systemFontOfSize:15];
}

- (IBAction)generate:(id)sender {
    NSString *str = inputTextView.textStorage.string;
    NSArray *names = [str componentsSeparatedByCharactersInSet:
                      [NSCharacterSet newlineCharacterSet]];

    NSMutableArray *results = [NSMutableArray array];
    for (NSString *name in names) {
        NSString *path = [NSString stringWithFormat:@"%@ohcard/%@/%@", domain.stringValue, pathTextField.stringValue, name];
        [results addObject:path];
    }
    NSString *back = results.firstObject;
    [results removeObjectAtIndex:0];
    NSData *data = [NSJSONSerialization dataWithJSONObject:results options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSString *exports = @"module.exports = {\n\
        name: \"人像卡副卡\",\n\
        back: \"%@\",\n\
        cards: %@\n}";
    NSString *result = [NSString stringWithFormat:exports, back, json];
    [resultTextView insertText:result replacementRange:NSMakeRange(0, resultTextView.string.length)];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
