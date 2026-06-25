
### SDL3.c3l

#### Info
- Module name is `sdl` (short, no version digit — the SDL3 version is an implementation detail of the vendored release). The package directory remains `sdl3.c3l` and `manifest.json` still `provides: sdl3` so consumers install it via `c3c vendor-fetch sdl3`.
- Function names are `snake_case` with the `SDL_` prefix stripped: `SDL_FunctionName` → `sdl::function_name`. Sub-APIs lift into sub-modules: `SDL_EGL_FunctionName` → `sdl::egl::function_name`, `SDL_GL_FunctionName` → `sdl::gl::function_name`, similarly `sdl::hid`, `sdl::stdinc`.
- Typedefs, structs, enums, and bitstructs are `PascalCase` with the library prefix stripped: `SDL_Window` → `sdl::Window`, `SDL_InitFlags` → `sdl::InitFlags`. Acronym-only type names are spelled as a readable PascalCase token to satisfy C3's lexer: `SDL_GUID` → `sdl::Guid`, `SDL_MSG` → `sdl::Msg`, `SDL_TLSID` → `sdl::TlsID`.
- Flag typedefs are modeled as C3 bitstructs where the underlying C layout permits it.
- Constants and enum values are `SCREAMING_SNAKE_CASE` with the prefix stripped: `SDL_INIT_VIDEO` → `sdl::INIT_VIDEO`.
- `@cname("SDL_...")` attributes preserve the exact C symbol name — only the C3-side identifier is renamed.
- Types from `SDL_stdinc.h` are included, functions are not.

#### Documentation
https://wiki.libsdl.org/SDL3/FrontPage

## Use (git submodule)

    git submodule add https://github.com/fesoliveira014/sdl3.c3l lib/sdl3.c3l

Then in `project.json`: `"dependency-search-paths": [ "lib" ]`, `"dependencies": [ "sdl3" ]`.
The module is `sdl`. This repo ships bindings only — provide your own SDL3 library to link.
