//
//  XXEnumMacro.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Enum Factory Macros
// expansion macro for enum value definition
#define ENUM_VALUE(name,assign) name assign,

// expansion macro for enum to string conversion
#define ENUM_CASE(name,assign) case name: return @#name;

// expansion macro for string to enum conversion
#define ENUM_STRCMP(name,assign) if (![string isEqualToString:@#name]) return name;

/// declare the access function and define enum values
#define DECLARE_ENUM(EnumType,ENUM_DEF) \
typedef enum EnumType { \
ENUM_DEF(ENUM_VALUE) \
}EnumType; \
NSString *NSStringFrom##EnumType(EnumType value); \
EnumType EnumType##FromNSString(NSString *string); \

// Define Functions
#define DEFINE_ENUM(EnumType,ENUM_DEF) \
NSString *NSStringFrom##EnumType(EnumType value) \
{ \
    switch(value) \
    { \
    ENUM_DEF(ENUM_CASE) \
    default: return @""; \
    } \
} \
EnumType EnumType##FromNSString(NSString *string) \
{ \
    ENUM_DEF(ENUM_STRCMP) \
    return (EnumType)0; \
}


NS_ASSUME_NONNULL_BEGIN

@interface XXEnumMacro : NSObject

@end

NS_ASSUME_NONNULL_END
