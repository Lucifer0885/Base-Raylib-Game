#include "gameMain.hpp"
#include <fstream>
#include <iostream>
#include <raylib.h>


struct GameData {
  int fps = 240;
  float positionX = 175;
  float positionY = 175;
  float width = 100;
  float height = 100;
  Color color = {0, 255, 0, 127};
  float speed = 200;
} gameData;

bool initGame() { return true; }

bool updateGame() {

  float deltaTime = GetFrameTime();
  if (deltaTime > 1.f / 5) { deltaTime = 1.f / 5; }
  
  if (IsKeyDown(KEY_RIGHT)) {
    gameData.positionX += gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_LEFT)) {
    gameData.positionX -= gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_DOWN)) {
    gameData.positionY += gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_UP)) {
    gameData.positionY -= gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_D)) {
    gameData.positionX += gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_A)) {
    gameData.positionX -= gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_S)) {
    gameData.positionY += gameData.speed * deltaTime;
  }
  if (IsKeyDown(KEY_W)) {
    gameData.positionY -= gameData.speed * deltaTime;
  }

  if (IsKeyDown(KEY_SPACE)) {
    gameData.color = {(unsigned char)GetRandomValue(0, 255),
                      (unsigned char)GetRandomValue(0, 255),
                      (unsigned char)GetRandomValue(0, 255), 127};
  }

  DrawRectangle(gameData.positionX, gameData.positionY, gameData.width,
                gameData.height, gameData.color);
  return true;
}

void closeGame() {
  std::cout << "Closing game..." << std::endl;
  std::ofstream outFile(RESOURCES_PATH "game.log");
  outFile << "Game closed" << std::endl;
  outFile.close();
}