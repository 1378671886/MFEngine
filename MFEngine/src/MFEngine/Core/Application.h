#pragma once

#include "Core.h"
#include "MFEngine/Core/LayerStack.h"
#include "MFEngine/Events/Event.h"
#include "MFEngine/Events/ApplicaitionEvent.h"
#include "Window.h"

namespace MFEngine
{
    class MFENGINE_API Application
    {
    public:
        Application();
        virtual ~Application();

        void Run();
        void OnEvent(Event& e);

        void PushLayer(Layer* layer);
        void PushOverlay(Layer* overlay);

    private:
        bool OnWindowClose(WindowCloseEvent& e);
        
        std::unique_ptr<Window> m_Window;
        bool m_Running = true;
        LayerStack m_LayerStack;
    };

    //在客户端中定义
    Application* CreateApplication();

}