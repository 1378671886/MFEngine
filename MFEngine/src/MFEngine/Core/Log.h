#pragma once

#include "Core.h"
#include "spdlog/spdlog.h"
#include "spdlog/fmt/ostr.h"

namespace MFEngine
{
    class MFENGINE_API Log
    {
        public:
            static void Init();
            inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() { return s_CoreLogger; }
            inline static std::shared_ptr<spdlog::logger>& GetClientLogger() { return s_ClientLogger; }

        private:
            static std::shared_ptr<spdlog::logger> s_CoreLogger;
            static std::shared_ptr<spdlog::logger> s_ClientLogger;

    };
}

//Core 日志宏
#define MFENGINE_CORE_ERROR(...) ::MFEngine::Log::GetCoreLogger()->error(__VA_ARGS__)
#define MFENGINE_CORE_WARN(...)  ::MFEngine::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define MFENGINE_CORE_INFO(...)  ::MFEngine::Log::GetCoreLogger()->info(__VA_ARGS__)
#define MFENGINE_CORE_TRACE(...) ::MFEngine::Log::GetCoreLogger()->trace(__VA_ARGS__)
#define MFENGINE_CORE_FATAL(...) ::MFEngine::Log::GetCoreLogger()->fatal(__VA_ARGS__)

//客户端日志宏
#define MFENGINE_ERROR(...) ::MFEngine::Log::GetClientLogger()->error(__VA_ARGS__)
#define MFENGINE_WARN(...)  ::MFEngine::Log::GetClientLogger()->warn(__VA_ARGS__)
#define MFENGINE_INFO(...)  ::MFEngine::Log::GetClientLogger()->info(__VA_ARGS__)
#define MFENGINE_TRACE(...) ::MFEngine::Log::GetClientLogger()->trace(__VA_ARGS__)
#define MFENGINE_FATAL(...) ::MFEngine::Log::GetClientLogger()->fatal(__VA_ARGS__)