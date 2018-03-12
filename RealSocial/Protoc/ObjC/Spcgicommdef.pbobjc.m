// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: spcgicommdef.proto

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

 #import "Spcgicommdef.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - RSSpcgicommdefRoot

@implementation RSSpcgicommdefRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - Enum RSenCgiErrorCode

GPBEnumDescriptor *RSenCgiErrorCode_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "KOk\000KErrArgs\000KErrSys\000";
    static const int32_t values[] = {
        RSenCgiErrorCode_KOk,
        RSenCgiErrorCode_KErrArgs,
        RSenCgiErrorCode_KErrSys,
    };
    static const char *extraTextFormatInfo = "\003\000\"A\000\001(\000\002\'\000";
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenCgiErrorCode)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenCgiErrorCode_IsValidValue
                              extraTextFormatInfo:extraTextFormatInfo];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenCgiErrorCode_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenCgiErrorCode_KOk:
    case RSenCgiErrorCode_KErrArgs:
    case RSenCgiErrorCode_KErrSys:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenLoginOpCode

GPBEnumDescriptor *RSenLoginOpCode_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "LoginOpcodeHome\000LoginOpcodeRegisterFace\000";
    static const int32_t values[] = {
        RSenLoginOpCode_LoginOpcodeHome,
        RSenLoginOpCode_LoginOpcodeRegisterFace,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenLoginOpCode)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenLoginOpCode_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenLoginOpCode_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenLoginOpCode_LoginOpcodeHome:
    case RSenLoginOpCode_LoginOpcodeRegisterFace:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenAddFriendOpCode

GPBEnumDescriptor *RSenAddFriendOpCode_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "AddFriendopcodeSucc\000AddFriendopcodeFail\000";
    static const int32_t values[] = {
        RSenAddFriendOpCode_AddFriendopcodeSucc,
        RSenAddFriendOpCode_AddFriendopcodeFail,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenAddFriendOpCode)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenAddFriendOpCode_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenAddFriendOpCode_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenAddFriendOpCode_AddFriendopcodeSucc:
    case RSenAddFriendOpCode_AddFriendopcodeFail:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenSex

GPBEnumDescriptor *RSenSex_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "SexUnknow\000SexMale\000SexFemale\000";
    static const int32_t values[] = {
        RSenSex_SexUnknow,
        RSenSex_SexMale,
        RSenSex_SexFemale,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenSex)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenSex_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenSex_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenSex_SexUnknow:
    case RSenSex_SexMale:
    case RSenSex_SexFemale:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenDeviceType

GPBEnumDescriptor *RSenDeviceType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "DevicetypeIphone\000DevicetypeAndriod\000";
    static const int32_t values[] = {
        RSenDeviceType_DevicetypeIphone,
        RSenDeviceType_DevicetypeAndriod,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenDeviceType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenDeviceType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenDeviceType_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenDeviceType_DevicetypeIphone:
    case RSenDeviceType_DevicetypeAndriod:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenSpaceType

GPBEnumDescriptor *RSenSpaceType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "SpaceTypeSingle\000SpaceTypeGroup\000";
    static const int32_t values[] = {
        RSenSpaceType_SpaceTypeSingle,
        RSenSpaceType_SpaceTypeGroup,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenSpaceType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenSpaceType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenSpaceType_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenSpaceType_SpaceTypeSingle:
    case RSenSpaceType_SpaceTypeGroup:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenStarType

GPBEnumDescriptor *RSenStarType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "StarTypeImg\000StarTypeVideo\000";
    static const int32_t values[] = {
        RSenStarType_StarTypeImg,
        RSenStarType_StarTypeVideo,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenStarType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenStarType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenStarType_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenStarType_StarTypeImg:
    case RSenStarType_StarTypeVideo:
      return YES;
    default:
      return NO;
  }
}

#pragma mark - Enum RSenReceiverType

GPBEnumDescriptor *RSenReceiverType_EnumDescriptor(void) {
  static GPBEnumDescriptor *descriptor = NULL;
  if (!descriptor) {
    static const char *valueNames =
        "ReceiverTypeCreator\000ReceiverTypeList\000Rec"
        "eiverTypeCreatorFriend\000ReceiverTypeAutho"
        "r\000ReceiverTypeAuthorFriend\000";
    static const int32_t values[] = {
        RSenReceiverType_ReceiverTypeCreator,
        RSenReceiverType_ReceiverTypeList,
        RSenReceiverType_ReceiverTypeCreatorFriend,
        RSenReceiverType_ReceiverTypeAuthor,
        RSenReceiverType_ReceiverTypeAuthorFriend,
    };
    GPBEnumDescriptor *worker =
        [GPBEnumDescriptor allocDescriptorForName:GPBNSStringifySymbol(RSenReceiverType)
                                       valueNames:valueNames
                                           values:values
                                            count:(uint32_t)(sizeof(values) / sizeof(int32_t))
                                     enumVerifier:RSenReceiverType_IsValidValue];
    if (!OSAtomicCompareAndSwapPtrBarrier(nil, worker, (void * volatile *)&descriptor)) {
      [worker release];
    }
  }
  return descriptor;
}

BOOL RSenReceiverType_IsValidValue(int32_t value__) {
  switch (value__) {
    case RSenReceiverType_ReceiverTypeCreator:
    case RSenReceiverType_ReceiverTypeList:
    case RSenReceiverType_ReceiverTypeCreatorFriend:
    case RSenReceiverType_ReceiverTypeAuthor:
    case RSenReceiverType_ReceiverTypeAuthorFriend:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
