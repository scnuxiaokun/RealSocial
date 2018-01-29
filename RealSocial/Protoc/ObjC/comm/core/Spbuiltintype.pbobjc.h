// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: comm/core/spbuiltintype.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - SpbuiltintypeRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface SpbuiltintypeRoot : GPBRootObject
@end

@interface SpbuiltintypeRoot (DynamicMethods)
+ (GPBExtensionDescriptor *)cmdId;
+ (GPBExtensionDescriptor *)optString;
+ (GPBExtensionDescriptor *)usage;
+ (GPBExtensionDescriptor *)port;
@end

#pragma mark - SPBuiltinInt32_PB

typedef GPB_ENUM(SPBuiltinInt32_PB_FieldNumber) {
  SPBuiltinInt32_PB_FieldNumber_Val = 1,
};

@interface SPBuiltinInt32_PB : GPBMessage

@property(nonatomic, readwrite) int32_t val;

@property(nonatomic, readwrite) BOOL hasVal;
@end

#pragma mark - SPBuiltinUint32_PB

typedef GPB_ENUM(SPBuiltinUint32_PB_FieldNumber) {
  SPBuiltinUint32_PB_FieldNumber_Val = 1,
};

@interface SPBuiltinUint32_PB : GPBMessage

@property(nonatomic, readwrite) uint32_t val;

@property(nonatomic, readwrite) BOOL hasVal;
@end

#pragma mark - SPBuiltinInt64_PB

typedef GPB_ENUM(SPBuiltinInt64_PB_FieldNumber) {
  SPBuiltinInt64_PB_FieldNumber_Val = 1,
};

@interface SPBuiltinInt64_PB : GPBMessage

@property(nonatomic, readwrite) int64_t val;

@property(nonatomic, readwrite) BOOL hasVal;
@end

#pragma mark - SPBuiltinUint64_PB

typedef GPB_ENUM(SPBuiltinUint64_PB_FieldNumber) {
  SPBuiltinUint64_PB_FieldNumber_Val = 1,
};

@interface SPBuiltinUint64_PB : GPBMessage

@property(nonatomic, readwrite) uint64_t val;

@property(nonatomic, readwrite) BOOL hasVal;
@end

#pragma mark - SPBuiltinEmpty_PB

@interface SPBuiltinEmpty_PB : GPBMessage

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
