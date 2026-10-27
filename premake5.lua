workspace "MFEngine"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

    -- GLFW 官方源码（MFEngine/vendor/glfw 是 git submodule，来自 github.com/glfw/glfw）
    -- 官方仓库不带 premake 脚本，所以在这里定义工程；location 保持在 vendor/glfw，
    -- 生成的 Makefile 和 GLFW.lib 位置与以前一致。
    project "GLFW"
        location "MFEngine/vendor/glfw"
        kind "StaticLib"
        language "C"
        staticruntime "off"
        warnings "off"

        targetdir ("MFEngine/vendor/glfw/bin/" .. outputdir .. "/%{prj.name}")
        objdir ("MFEngine/vendor/glfw/bin-int/" .. outputdir .. "/%{prj.name}")

        files
        {
            "MFEngine/vendor/glfw/include/GLFW/glfw3.h",
            "MFEngine/vendor/glfw/include/GLFW/glfw3native.h",

            "MFEngine/vendor/glfw/src/context.c",
            "MFEngine/vendor/glfw/src/init.c",
            "MFEngine/vendor/glfw/src/input.c",
            "MFEngine/vendor/glfw/src/monitor.c",
            "MFEngine/vendor/glfw/src/platform.c",
            "MFEngine/vendor/glfw/src/vulkan.c",
            "MFEngine/vendor/glfw/src/window.c",

            "MFEngine/vendor/glfw/src/null_init.c",
            "MFEngine/vendor/glfw/src/null_joystick.c",
            "MFEngine/vendor/glfw/src/null_monitor.c",
            "MFEngine/vendor/glfw/src/null_window.c",
        }

        filter "system:windows"
            systemversion "latest"

            files
            {
                "MFEngine/vendor/glfw/src/win32_init.c",
                "MFEngine/vendor/glfw/src/win32_joystick.c",
                "MFEngine/vendor/glfw/src/win32_module.c",
                "MFEngine/vendor/glfw/src/win32_monitor.c",
                "MFEngine/vendor/glfw/src/win32_time.c",
                "MFEngine/vendor/glfw/src/win32_thread.c",
                "MFEngine/vendor/glfw/src/win32_window.c",
                "MFEngine/vendor/glfw/src/wgl_context.c",
                "MFEngine/vendor/glfw/src/egl_context.c",
                "MFEngine/vendor/glfw/src/osmesa_context.c",
            }

            defines
            {
                "_GLFW_WIN32",
                "_CRT_SECURE_NO_WARNINGS",
            }

        filter "configurations:Debug"
            symbols "on"

        filter "configurations:Release"
            optimize "speed"

        filter "configurations:Dist"
            optimize "speed"
            symbols "off"

project "MFEngine"
    location "MFEngine"
    kind "SharedLib"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    pchheader "mfpch.h"
    pchsource "MFEngine/src/mfpch.cpp"

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    -- 这两个文件是从教程后面的章节复制的，依赖还没实现的 Input / PlatformUtils，暂时不参与编译
    removefiles
    {
        "MFEngine/src/Platform/WindowsInput.cpp",
        "MFEngine/src/Platform/WindowsPlatformUtils.cpp"
    }

    includedirs
    {
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include",
        "%{prj.name}/vendor/glfw/include"
    }

    links
    {
        "GLFW"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "MFENGINE_PLATFORM_WINDOWS",
            "MFENGINE_BUILD_DLL"
        }

        -- GLFW 的 Windows 实现要用到这些系统库，Cherno 的 premake5.lua 里没写，需要自己补
        links
        {
            "opengl32",
            "gdi32",
            "user32",
            "shell32"
        }

        postbuildcommands
        {
            ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
        }

    filter "configurations:Debug"
        defines "MFENGINE_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "MFENGINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "MFENGINE_DIST"
        optimize "On"

project "Sandbox"
    location "Sandbox"
    kind "ConsoleApp"
    language "C++"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.cpp"
    }

    includedirs
    {
        "MFEngine/vendor/spdlog/include",
        "MFEngine/vendor/glfw/include",
        "MFEngine/src"
    }

    filter "system:windows"
        forceincludes { "mfpch.h" }

    links
    {
        "GLFW",
        "MFEngine"
    }

    filter "system:windows"
        cppdialect "C++17"
        staticruntime "On"
        systemversion "latest"

        defines
        {
            "MFENGINE_PLATFORM_WINDOWS"
        }

    filter "configurations:Debug"
        defines "MFENGINE_DEBUG"
        symbols "On"

    filter "configurations:Release"
        defines "MFENGINE_RELEASE"
        optimize "On"

    filter "configurations:Dist"
        defines "MFENGINE_DIST"
        optimize "On"