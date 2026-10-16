#pragma once

#ifdef MFENGINE_PLATFORM_WINDOWS

extern MFEngine::Application* MFEngine::CreateApplication();

int main(int argc, char** argv)
{
    MFEngine::Log::Init();
    MFENGINE_CORE_WARN("Initialized Log!");
    int a = 5;
    MFENGINE_INFO("Hello! Var={0}", a);
    MFENGINE_INFO("Hello! This is an info log!");

    MFEngine::Application* app = MFEngine::CreateApplication();
    app->Run();
    delete app;
}

#endif