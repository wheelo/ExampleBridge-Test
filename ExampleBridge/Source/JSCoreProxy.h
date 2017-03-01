//
//  ChakraProxy.h
//  ExampleBridge
//
//  Originally created by Alexey Kureev on 28/09/2016(adapted by Erik Peng on 01/03/2017).
//  Copyright © 2016 oss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol JSCoreProxyExport <JSExport>
-(void)render:(NSString *)name setWidth:(NSNumber *)width setHeight:(NSNumber *)height;
// support callback
// -(void)render:(NSString *)message;

@end



@interface JSCoreProxy : NSObject<JSCoreProxyExport>

// strong or weak ?
//@property (strong, nonatomic) JSContext *jsContext;

-(void)run;

@end
