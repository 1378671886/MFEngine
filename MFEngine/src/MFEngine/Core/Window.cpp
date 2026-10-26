#include "mfpch.h"
#include "MFEngine/Core/Window.h"

#ifdef MFENGINE_PLATFORM_WINDOWS
	#include "Platform/WindowsWindow.h"
#endif

namespace MFEngine
{
	Scope<Window> Window::Create(const WindowProps& props)
	{
	#ifdef MFENGINE_PLATFORM_WINDOWS
		return CreateScope<WindowsWindow>(props);
	#else
		MFENGINE_CORE_ASSERT(false, "Unknown platform!");
		return nullptr;
	#endif
	}

}
