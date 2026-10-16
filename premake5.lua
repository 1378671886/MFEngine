workspace "MFEngine"
    architecture "x64"

    configurations
    {
        "Debug",
        "Release",
        "Dist"
    }

    outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project "MFEngine"
    location "MFEngine"
    kind "SharedLib"
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
        "%{prj.name}/src",
        "%{prj.name}/vendor/spdlog/include"
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
        "MFEngine/src"
    }

    links
    {
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