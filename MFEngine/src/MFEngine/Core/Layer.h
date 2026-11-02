#pragma once

#include "MFEngine/Core/Base.h"
#include "MFEngine/Core/Timestep.h"
#include "MFEngine/Events/Event.h"

namespace MFEngine 
{

	class MFENGINE_API Layer
	{
	public:
		Layer(const std::string& name = "Layer");
		virtual ~Layer() = default;

		virtual void OnAttach() {}
		virtual void OnDetach() {}
		virtual void OnUpdate(Timestep ts) {}
		virtual void OnImGuiRender() {}
		virtual void OnEvent(Event& event) {}

		const std::string& GetName() const { return m_DebugName; }
	protected:
		std::string m_DebugName;
	};

}
