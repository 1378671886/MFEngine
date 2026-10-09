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

int main()
{
    Sandbox* sandbox = new Sandbox();
    sandbox->Run();

    delete sandbox;
}