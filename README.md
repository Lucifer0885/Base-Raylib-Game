# Base Raylib Game Template

A C++ game project built on [Raylib](https://www.raylib.com/) with [Dear ImGui](https://github.com/ocornut/imgui) for debug/editor UI. Still early — right now it's mostly scaffolding and a small demo to prove the loop works.

## What it does

- Opens a resizable window (1366x720 by default)
- Renders a rectangle you can move with arrow keys or WASD
- Press Space to randomize the rectangle color
- ImGui docking is enabled, with a couple of test windows and an FPS cap slider

## Requirements

- CMake 4.1+
- A C++23 compiler (MSVC, GCC, or Clang)
- On Windows, Visual Studio 2022 or a recent MSVC toolchain works fine

## Building

From the project root:

```bash
cmake -B build
cmake --build build
```

The executable ends up in `build/` as `Game.exe` on Windows (or just `Game` elsewhere).

If you're using Visual Studio, you can also open the folder and let CMake configure it for you. The `build/` directory is gitignored — use whatever out-of-source build folder you prefer.

## Running

Run the executable from a working directory where it can find the `resources/` folder. In a dev build, assets resolve to the project's `resources/` path automatically via the `RESOURCES_PATH` compile definition.

On shutdown, the game writes a line to `resources/game.log`.

## Project layout

```
src/
  platform/     Entry point, window setup, main loop
  gameLayer/    Game init, update, and cleanup
  ImGui/        UI layers and themes
resources/      Runtime assets (logs, etc.)
thirdparty/     Raylib, ImGui (docking), rlImGui
```

Source files under `src/` are picked up automatically by CMake — you don't need to add them to `CMakeLists.txt` by hand.

## Dev vs production builds

`PRODUCTION_BUILD` is set in `CMakeLists.txt` (defaults to `OFF`).

- **Dev (`OFF`)**: `RESOURCES_PATH` points at the source tree's `resources/` folder. Console stays open. Good for iterating in the IDE.
- **Production (`ON`)**: `RESOURCES_PATH` becomes `./resources/` relative to the exe. Logging is silenced and the console window is removed on Windows.

Flip the flag, reconfigure CMake, and rebuild. If Visual Studio doesn't pick up the change, delete your build folder and configure again.

## Controls

| Key | Action |
|-----|--------|
| Arrow keys / WASD | Move the rectangle |
| Space | Randomize rectangle color |

## Third-party libraries

- [raylib 6.0](thirdparty/raylib-6.0)
- [imgui-docking](thirdparty/imgui-docking)
- [rlimgui](thirdparty/rlimgui)

All linked statically. Each has its own license — see the respective directories.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
