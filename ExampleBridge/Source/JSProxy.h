//
//  ChakraProxy.h
//  ExampleBridge
//
//  Created by Alexey Kureev on 28/09/2016.
//  Copyright © 2016 oss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol ChakraProxyExport <JSExport>
-(void)render:(NSString *)name setWidth:(NSNumber *)width setHeight:(NSNumber *)height;
// support callback
// -(void)render:(NSString *)message;

@end



@interface ChakraProxy : NSObject<ChakraProxyExport>

// strong or weak ?
//@property (strong, nonatomic) JSContext *jsContext;

-(void)run;

@end
