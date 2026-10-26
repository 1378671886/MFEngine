#pragma once

#include <memory>
#include <utility>

#include "Log.h"

namespace MFEngine
{
	//智能指针别名（和教程里的 Base.h 对应）
	template<typename T>
	using Scope = std::unique_ptr<T>;

	template<typename T, typename... Args>
	constexpr Scope<T> CreateScope(Args&&... args)
	{
		return std::make_unique<T>(std::forward<Args>(args)...);
	}

	template<typename T>
	using Ref = std::shared_ptr<T>;

	template<typename T, typename... Args>
	constexpr Ref<T> CreateRef(Args&&... args)
	{
		return std::make_shared<T>(std::forward<Args>(args)...);
	}
}

//调试断点：MSVC 用 __debugbreak()，MinGW/GCC 用 __builtin_trap()
#if defined(_MSC_VER)
	#define MFENGINE_DEBUGBREAK() __debugbreak()
#elif defined(__GNUC__)
	#define MFENGINE_DEBUGBREAK() __builtin_trap()
#else
	#define MFENGINE_DEBUGBREAK()
#endif

//断言
#define MFENGINE_CORE_ASSERT(x, ...) { if(!(x)) { MFENGINE_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); MFENGINE_DEBUGBREAK(); } }
#define MFENGINE_ASSERT(x, ...) { if(!(x)) { MFENGINE_ERROR("Assertion Failed: {0}", __VA_ARGS__); MFENGINE_DEBUGBREAK(); } }
