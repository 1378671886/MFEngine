#include "MFEngine.h"

class Sandbox : public MFEngine::Application
{
public:
    Sandbox()
    {

    }

    ~Sandbox()
    {

    }

};

MFEngine::Application* MFEngine::CreateApplication()
{
    return new Sandbox();
}