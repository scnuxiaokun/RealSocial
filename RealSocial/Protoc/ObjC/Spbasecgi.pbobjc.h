// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spbasecgi.proto

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

@class RSBaseReq;
@class RSBaseResp;
@class RSContact;
@class RSProfile;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - RSSpbasecgiRoot

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
@interface RSSpbasecgiRoot : GPBRootObject
@end

#pragma mark - RSLoginReq

typedef GPB_ENUM(RSLoginReq_FieldNumber) {
  RSLoginReq_FieldNumber_BaseReq = 1,
  RSLoginReq_FieldNumber_Code = 2,
};

@interface RSLoginReq : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) RSBaseReq *baseReq;
/** Test to see if @c baseReq has been set. */
@property(nonatomic, readwrite) BOOL hasBaseReq;

@property(nonatomic, readwrite, copy, null_resettable) NSString *code;
/** Test to see if @c code has been set. */
@property(nonatomic, readwrite) BOOL hasCode;

@end

#pragma mark - RSLoginResp

typedef GPB_ENUM(RSLoginResp_FieldNumber) {
  RSLoginResp_FieldNumber_BaseResp = 1,
  RSLoginResp_FieldNumber_OpCode = 2,
  RSLoginResp_FieldNumber_UserName = 3,
  RSLoginResp_FieldNumber_SessionKey = 4,
  RSLoginResp_FieldNumber_QiniuToken = 5,
  RSLoginResp_FieldNumber_Profile = 6,
};

@interface RSLoginResp : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) RSBaseResp *baseResp;
/** Test to see if @c baseResp has been set. */
@property(nonatomic, readwrite) BOOL hasBaseResp;

@property(nonatomic, readwrite) uint32_t opCode;

@property(nonatomic, readwrite) BOOL hasOpCode;
@property(nonatomic, readwrite, copy, null_resettable) NSString *userName;
/** Test to see if @c userName has been set. */
@property(nonatomic, readwrite) BOOL hasUserName;

@property(nonatomic, readwrite, copy, null_resettable) NSData *sessionKey;
/** Test to see if @c sessionKey has been set. */
@property(nonatomic, readwrite) BOOL hasSessionKey;

@property(nonatomic, readwrite, copy, null_resettable) NSString *qiniuToken;
/** Test to see if @c qiniuToken has been set. */
@property(nonatomic, readwrite) BOOL hasQiniuToken;

@property(nonatomic, readwrite, strong, null_resettable) RSProfile *profile;
/** Test to see if @c profile has been set. */
@property(nonatomic, readwrite) BOOL hasProfile;

@end

#pragma mark - RSGetAllContactReq

typedef GPB_ENUM(RSGetAllContactReq_FieldNumber) {
  RSGetAllContactReq_FieldNumber_BaseReq = 1,
};

@interface RSGetAllContactReq : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) RSBaseReq *baseReq;
/** Test to see if @c baseReq has been set. */
@property(nonatomic, readwrite) BOOL hasBaseReq;

@end

#pragma mark - RSGetAllContactResp

typedef GPB_ENUM(RSGetAllContactResp_FieldNumber) {
  RSGetAllContactResp_FieldNumber_BaseResp = 1,
  RSGetAllContactResp_FieldNumber_ContactArray = 2,
};

@interface RSGetAllContactResp : GPBMessage

@property(nonatomic, readwrite, strong, null_resettable) RSBaseResp *baseResp;
/** Test to see if @c baseResp has been set. */
@property(nonatomic, readwrite) BOOL hasBaseResp;

@property(nonatomic, readwrite, strong, null_resettable) NSMutableArray<RSContact*> *contactArray;
/** The number of items in @c contactArray without causing the array to be created. */
@property(nonatomic, readonly) NSUInteger contactArray_Count;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
