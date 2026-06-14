#include "ImGuiMainLayer.hpp"
#include "imgui.h"
#include "ImGuiThemes/ImGuiThemes.hpp"
#include <raylib.h>

bool ImGuiMainLayer::Setup() {
	ImGuiThemes::SetupImGuiCrimsonVesuviusStyle();
	ImGuiIO &io = ImGui::GetIO();
	io.FontGlobalScale = 1.0f;
	io.ConfigFlags |= ImGuiConfigFlags_DockingEnable;
  
  return true;
}

void ImGuiMainLayer::Draw() {
  ImGui::DockSpaceOverViewport(0, NULL, ImGuiDockNodeFlags_PassthruCentralNode);
	ImGuiIO &io = ImGui::GetIO();
	static int fps = GetFPS();
  ImGui::Begin("Test Window");
  ImGui::Text("Hello, World!");
  ImGui::Button("Click me");
  ImGui::End();

  ImGui::Begin("FPS");
  ImGui::Text("FPS: %d", GetFPS());
  ImGui::Separator();
  ImGui::InputInt("FPS", &fps);
  if (ImGui::Button("Apply FPS")) {
    SetTargetFPS(fps);
  }
  ImGui::End();
}