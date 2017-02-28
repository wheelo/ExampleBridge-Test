//
//  ChakraProxy.m
//  ExampleBridge
//
//  Created by Alexey Kureev on 28/09/2016.
//  Copyright © 2016 oss. All rights reserved.
//

#import "JSProxy.h"

#import "EBWindow.h"
#import "AppDelegate.h"


static JSContext *jsContext;



@implementation ChakraProxy


-(void)render:(NSString *)name setWidth:(NSNumber *)width setHeight:(NSNumber *)height {
    
    NSString *type = name;
    
    // to CGFloat
    // double w {ChakraUtils::toDouble(arguments[2])};
    // double h {ChakraUtils::toDouble(arguments[3])};
    
    dispatch_async(dispatch_get_main_queue(), ^{
        id delegate = [[NSApplication sharedApplication] delegate];
        
        [delegate renderElementOfType:type size:NSMakeSize([width doubleValue], [height doubleValue])];
    });
    
}

-(void)run {
    // unsigned currentSourceContext = 0;
    
    // Read file from the bundle
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading file: %@", error.localizedDescription);
    
    
    
    jsContext = [[JSContext alloc] initWithVirtualMachine:[[JSVirtualMachine alloc] init]];
    
    
    ChakraProxy *render=[ChakraProxy new];

    jsContext[@"bridge"] = render;

    
    // SetupGlobalEnvironment();
    
    
    // Run the script.
    [jsContext evaluateScript:fileContents];
    
    
    // Run the script.
    //JsRunScriptUtf8(script, currentSourceContext++, "", nullptr);
}

@end
