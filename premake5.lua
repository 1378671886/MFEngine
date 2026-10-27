workspace "MFEngine"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

    -- 引入 GLFW 子模块自带的 premake5.lua，生成 GLFW 静态库工程
    include "MFEngine/vendor/glfw"

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