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
        "StoryTypePrivate\000StoryTypePublic\000";
    static const int32_t values[] = {
        RSenSpaceType_StoryTypePrivate,
        RSenSpaceType_StoryTypePublic,
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
    case RSenSpaceType_StoryTypePrivate:
    case RSenSpaceType_StoryTypePublic:
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
        "StoryItemTypeImg\000StoryItemTypeVideo\000";
    static const int32_t values[] = {
        RSenStarType_StoryItemTypeImg,
        RSenStarType_StoryItemTypeVideo,
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
    case RSenStarType_StoryItemTypeImg:
    case RSenStarType_StoryItemTypeVideo:
      return YES;
    default:
      return NO;
  }
}


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
