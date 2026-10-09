#pragma once

#ifdef MFENGINE_PLATFORM_WINDOWS
    #ifdef MFENGINE_BUILD_DLL
        #define MFENGINE_API __declspec(dllexport)
    #else
        #define MFENGINE_API __declspec(dllimport)
    #endif
#else
    #error MFEngine only supports Windows!
#endif