// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: LoginInfo.proto

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

@class FriendInfo;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - LoginInfoRoot

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
@interface LoginInfoRoot : GPBRootObject
@end

#pragma mark - LoginInfo

typedef GPB_ENUM(LoginInfo_FieldNumber) {
  LoginInfo_FieldNumber_SessionKey = 1,
  LoginInfo_FieldNumber_Wxuid = 2,
};

@interface LoginInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *sessionKey;

@property(nonatomic, readwrite, copy, null_resettable) NSString *wxuid;

@end

#pragma mark - FriendList

typedef GPB_ENUM(FriendList_FieldNumber) {
  FriendList_FieldNumber_ListArray = 1,
};

@interface FriendList : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<FriendInfo*> *listArray;
/** The number of items in @c listArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger listArray_Count;

@end

#pragma mark - FriendInfo

typedef GPB_ENUM(FriendInfo_FieldNumber) {
  FriendInfo_FieldNumber_Name = 1,
};

@interface FriendInfo : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *name;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
