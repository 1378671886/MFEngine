#include "MFEngine.h"

class ExampleLayer : public MFEngine::Layer
{
public:
    ExampleLayer()
        : Layer("Example")
    {

    }

    void OnUpdate(MFEngine::Timestep ts) override
    {
        MFENGINE_INFO("ExampleLayer::Update");
    }

    void OnEvent(MFEngine::Event& event) override
    {
        MFENGINE_TRACE("{0}", event.ToString());
    }
};

class Sandbox : public MFEngine::Application
{
public:
    Sandbox()
    {
        PushLayer(new ExampleLayer());
    }

    ~Sandbox()
    {

    }

};

MFEngine::Application* MFEngine::CreateApplication()
{
    return new Sandbox();
}