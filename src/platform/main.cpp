#include <raylib.h>

#include "rlImGui.h"

#include "gameMain.hpp"
#include "ImGuiLayers/ImGuiMainLayer.hpp"

int main()
{
	#if PRODUCTION_BUILD == 1
		SetTraceLogLevel(LOG_NONE);
	#endif

	SetConfigFlags(FLAG_WINDOW_RESIZABLE);
	InitWindow(1366, 720, "Aether");
	SetExitKey(KEY_NULL);
	SetTargetFPS(240);
	
	rlImGuiSetup(true);

	if (!ImGuiMainLayer::Setup()) {
		return 0;
	}

	if (!initGame()) {
		return 0;
	}

	while (!WindowShouldClose())
	{
		BeginDrawing();
		ClearBackground(BLACK);
		DrawText("Hello, World!", 50, 50, 20, BLACK);
		rlImGuiBegin();

		if (!updateGame()) {
			CloseWindow();
		}

		ImGuiMainLayer::Draw();

		rlImGuiEnd();
		EndDrawing();
	}
	CloseWindow();
	closeGame();
	rlImGuiShutdown();
	return 0;
}