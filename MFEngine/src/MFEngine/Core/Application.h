#pragma once

#include "Core.h"
#include "MFEngine/Events/Event.h"

namespace MFEngine
{
    class MFENGINE_API Application
    {
    public:
        Application();
        virtual ~Application();

        void Run();
    };

    //在客户端中定义
    Application* CreateApplication();

}