//
//  JSContextBridger.m
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <JavaScriptCore/JavaScriptCore.h>
JSValue *getJSVinJSC(JSContext *ctx, NSString *key) {
    return ctx[key];
}
void setJSVinJSC(JSContext *ctx, NSString *key, id val) {
    ctx[key] = val;
}
