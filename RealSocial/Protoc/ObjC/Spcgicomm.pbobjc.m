// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spcgicomm.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

 #import "Spcgicomm.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - RSSpcgicommRoot

@implementation RSSpcgicommRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - RSSpcgicommRoot_FileDescriptor

static GPBFileDescriptor *RSSpcgicommRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@"spcgi"
                                                 objcPrefix:@"RS"
                                                     syntax:GPBFileSyntaxProto2];
  }
  return descriptor;
}

#pragma mark - RSPKG

@implementation RSPKG

@dynamic hasStr, str;
@dynamic hasData_p, data_p;

typedef struct RSPKG__storage_ {
  uint32_t _has_storage_[1];
  NSData *str;
  NSData *data_p;
} RSPKG__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "str",
        .dataTypeSpecific.className = NULL,
        .number = RSPKG_FieldNumber_Str,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSPKG__storage_, str),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBytes,
      },
      {
        .name = "data_p",
        .dataTypeSpecific.className = NULL,
        .number = RSPKG_FieldNumber_Data_p,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSPKG__storage_, data_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSPKG class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSPKG__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001C\000\002\000Data\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RSBaseReq

@implementation RSBaseReq

@dynamic hasSessionKey, sessionKey;
@dynamic hasUin, uin;
@dynamic hasDeviceId, deviceId;
@dynamic hasDeviceType, deviceType;
@dynamic hasClientVersion, clientVersion;

typedef struct RSBaseReq__storage_ {
  uint32_t _has_storage_[1];
  uint32_t uin;
  uint32_t deviceType;
  uint32_t clientVersion;
  NSString *sessionKey;
  NSString *deviceId;
} RSBaseReq__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "sessionKey",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseReq_FieldNumber_SessionKey,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSBaseReq__storage_, sessionKey),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "uin",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseReq_FieldNumber_Uin,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSBaseReq__storage_, uin),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "deviceId",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseReq_FieldNumber_DeviceId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RSBaseReq__storage_, deviceId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "deviceType",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseReq_FieldNumber_DeviceType,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(RSBaseReq__storage_, deviceType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "clientVersion",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseReq_FieldNumber_ClientVersion,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(RSBaseReq__storage_, clientVersion),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSBaseReq class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSBaseReq__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\005\001J\000\002C\000\003GA\000\004J\000\005M\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RSBaseResp

@implementation RSBaseResp

@dynamic hasErrCode, errCode;
@dynamic hasErrMsg, errMsg;

typedef struct RSBaseResp__storage_ {
  uint32_t _has_storage_[1];
  uint32_t errCode;
  NSString *errMsg;
} RSBaseResp__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "errCode",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseResp_FieldNumber_ErrCode,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSBaseResp__storage_, errCode),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "errMsg",
        .dataTypeSpecific.className = NULL,
        .number = RSBaseResp_FieldNumber_ErrMsg,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSBaseResp__storage_, errMsg),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSBaseResp class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSBaseResp__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\002\001G\000\002F\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RSProfile

@implementation RSProfile

@dynamic hasUserName, userName;
@dynamic hasNickName, nickName;
@dynamic hasSex, sex;
@dynamic hasHeadImgURL, headImgURL;

typedef struct RSProfile__storage_ {
  uint32_t _has_storage_[1];
  uint32_t sex;
  NSString *userName;
  NSString *nickName;
  NSString *headImgURL;
} RSProfile__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "userName",
        .dataTypeSpecific.className = NULL,
        .number = RSProfile_FieldNumber_UserName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSProfile__storage_, userName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nickName",
        .dataTypeSpecific.className = NULL,
        .number = RSProfile_FieldNumber_NickName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSProfile__storage_, nickName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "sex",
        .dataTypeSpecific.className = NULL,
        .number = RSProfile_FieldNumber_Sex,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RSProfile__storage_, sex),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "headImgURL",
        .dataTypeSpecific.className = NULL,
        .number = RSProfile_FieldNumber_HeadImgURL,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(RSProfile__storage_, headImgURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSProfile class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSProfile__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\004\001H\000\002H\000\003C\000\004H!!\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RSMsg

@implementation RSMsg

@dynamic hasId_p, id_p;
@dynamic hasType, type;
@dynamic hasContent, content;

typedef struct RSMsg__storage_ {
  uint32_t _has_storage_[1];
  uint32_t type;
  NSData *content;
  uint64_t id_p;
} RSMsg__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "id_p",
        .dataTypeSpecific.className = NULL,
        .number = RSMsg_FieldNumber_Id_p,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSMsg__storage_, id_p),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt64,
      },
      {
        .name = "type",
        .dataTypeSpecific.className = NULL,
        .number = RSMsg_FieldNumber_Type,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSMsg__storage_, type),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "content",
        .dataTypeSpecific.className = NULL,
        .number = RSMsg_FieldNumber_Content,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RSMsg__storage_, content),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeBytes,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSMsg class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSMsg__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\003\001\000Id\000\002D\000\003G\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end

#pragma mark - RSContact

@implementation RSContact

@dynamic hasUserName, userName;
@dynamic hasNickName, nickName;
@dynamic hasSex, sex;
@dynamic hasHeadImgURL, headImgURL;

typedef struct RSContact__storage_ {
  uint32_t _has_storage_[1];
  uint32_t sex;
  NSString *userName;
  NSString *nickName;
  NSString *headImgURL;
} RSContact__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "userName",
        .dataTypeSpecific.className = NULL,
        .number = RSContact_FieldNumber_UserName,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(RSContact__storage_, userName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "nickName",
        .dataTypeSpecific.className = NULL,
        .number = RSContact_FieldNumber_NickName,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(RSContact__storage_, nickName),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "sex",
        .dataTypeSpecific.className = NULL,
        .number = RSContact_FieldNumber_Sex,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(RSContact__storage_, sex),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeUInt32,
      },
      {
        .name = "headImgURL",
        .dataTypeSpecific.className = NULL,
        .number = RSContact_FieldNumber_HeadImgURL,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(RSContact__storage_, headImgURL),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[RSContact class]
                                     rootClass:[RSSpcgicommRoot class]
                                          file:RSSpcgicommRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(RSContact__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\004\001H\000\002H\000\003C\000\004H!!\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    NSAssert(descriptor == nil, @"Startup recursed!");
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
