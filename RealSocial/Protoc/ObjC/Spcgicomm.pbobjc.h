// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spcgicomm.proto

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

#pragma mark - Enum RSenSex

typedef GPB_ENUM(RSenSex) {
  RSenSex_SexUnknow = 0,
  RSenSex_SexMale = 1,
  RSenSex_SexFemale = 2,
};

GPBEnumDescriptor *RSenSex_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL RSenSex_IsValidValue(int32_t value);

#pragma mark - RSSpcgicommRoot

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
@interface RSSpcgicommRoot : GPBRootObject
@end

#pragma mark - RSBaseReq

@interface RSBaseReq : GPBMessage

@end

#pragma mark - RSBaseResp

typedef GPB_ENUM(RSBaseResp_FieldNumber) {
  RSBaseResp_FieldNumber_ErrCode = 1,
  RSBaseResp_FieldNumber_ErrMsg = 2,
};

@interface RSBaseResp : GPBMessage

@property(nonatomic, readwrite) uint32_t errCode;

@property(nonatomic, readwrite) BOOL hasErrCode;
/** hhh */
@property(nonatomic, readwrite, copy, null_resettable) NSString *errMsg;
/** Test to see if @c errMsg has been set. */
@property(nonatomic, readwrite) BOOL hasErrMsg;

@end

#pragma mark - RSProfile

typedef GPB_ENUM(RSProfile_FieldNumber) {
  RSProfile_FieldNumber_NickName = 1,
  RSProfile_FieldNumber_Sex = 2,
  RSProfile_FieldNumber_HeadImgURL = 3,
};

@interface RSProfile : GPBMessage

@property(nonatomic, readwrite, copy, null_resettable) NSString *nickName;
/** Test to see if @c nickName has been set. */
@property(nonatomic, readwrite) BOOL hasNickName;

/** enSex */
@property(nonatomic, readwrite) uint32_t sex;

@property(nonatomic, readwrite) BOOL hasSex;
@property(nonatomic, readwrite, copy, null_resettable) NSString *headImgURL;
/** Test to see if @c headImgURL has been set. */
@property(nonatomic, readwrite) BOOL hasHeadImgURL;

@end

#pragma mark - RSMsg

typedef GPB_ENUM(RSMsg_FieldNumber) {
  RSMsg_FieldNumber_Id_p = 1,
  RSMsg_FieldNumber_Type = 2,
  RSMsg_FieldNumber_Content = 3,
};

@interface RSMsg : GPBMessage

@property(nonatomic, readwrite) uint64_t id_p;

@property(nonatomic, readwrite) BOOL hasId_p;
@property(nonatomic, readwrite) uint32_t type;

@property(nonatomic, readwrite) BOOL hasType;
@property(nonatomic, readwrite, copy, null_resettable) NSData *content;
/** Test to see if @c content has been set. */
@property(nonatomic, readwrite) BOOL hasContent;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)