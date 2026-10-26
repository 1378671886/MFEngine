#include "mfpch.h"
#include "Application.h"

#include "MFEngine/Events/ApplicaitionEvent.h"
#include "Log.h"

namespace MFEngine
{
    Application::Application()
    {
    }

    Application::~Application()
    {
    }

    void Application::Run()
    {
        WindowResizeEvent e(1280, 720);
        MFENGINE_TRACE(e.ToString());

        while (true);
    }
}