#pragma once

#ifdef MFENGINE_PLATFORM_WINDOWS

extern MFEngine::Application* MFEngine::CreateApplication();

int main(int argc, char** argv)
{
    MFEngine::Application* app = MFEngine::CreateApplication();
    app->Run();
    delete app;
}

#endif