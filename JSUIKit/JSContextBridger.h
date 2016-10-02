//
//  JSContextBridger.h
//  JSCorePlayground
//
//  Created by 田中 達也 on 2016/10/03.
//  Copyright © 2016年 tattn. All rights reserved.
//

#ifndef JSContextBridger_h
#define JSContextBridger_h

#import <JavaScriptCore/JavaScriptCore.h>
JSValue *getJSVinJSC(JSContext *ctx, NSString *key);
void setJSVinJSC(JSContext *ctx, NSString *key, id val);

#endif /* JSContextBridger_h */
