//
//  ChakraProxy.m
//  ExampleBridge
//
//  Originally created by Alexey Kureev on 28/09/2016(adapted by Erik Peng on 01/03/2017).
//  Copyright © 2016 oss. All rights reserved.
//

#import "JSCoreProxy.h"

// #import "EBWindow.h"
#import "AppDelegate.h"


static JSContext *jsContext;



@implementation JSCoreProxy



-(void)render:(NSString *)name setWidth:(NSNumber *)width setHeight:(NSNumber *)height {
    
    NSString *type = name;
    
    NSLog(@"Rendering");
    
    
    // to CGFloat
    // double w {ChakraUtils::toDouble(arguments[2])};
    // double h {ChakraUtils::toDouble(arguments[3])};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id delegate = [[NSApplication sharedApplication] delegate];
        
        
        [delegate renderElementOfType:type size:NSMakeSize([width doubleValue], [height doubleValue])];
    });
    
}



-(void)SetupGlobalEnvironment {
    jsContext = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    
    
    [jsContext setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"%@", expectValue);
    }];
    
    jsContext[@"log"] = ^(NSString *str) {
        NSLog(@"%@", str);
    };
    
    
    // can't find render method, huge bug..
    jsContext[@"bridge"] = self;
    
}




-(void)run {
    // unsigned currentSourceContext = 0;
    
    // Read file from the bundle
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    
    // JSCoreProxy *jsProxy = [JSCoreProxy new];
    
    [self SetupGlobalEnvironment];
    
    
    
    // Run the script.
    [jsContext evaluateScript:fileContents];
  
}

@end
