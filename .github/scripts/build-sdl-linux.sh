#!/usr/bin/env bash
# Build SDL3 statically for linux-x64 and copy libSDL3.a into linked-libs/linux-x64.
# Needs the X11, Wayland and ALSA development packages (see the workflows).
set -euo pipefail

SDL_TAG="${SDL_TAG:-release-3.4.16}"
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
work="${SDL_WORK:-$root/sdl-build}"

if [[ ! -d "$work/src/.git" ]]; then
    mkdir -p "$work"
    git clone --quiet --depth 1 --branch "$SDL_TAG" https://github.com/libsdl-org/SDL.git "$work/src"
fi

cmake -S "$work/src" -B "$work/build" -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DSDL_STATIC=ON -DSDL_SHARED=OFF \
    -DSDL_TEST_LIBRARY=OFF -DSDL_TESTS=OFF -DSDL_EXAMPLES=OFF \
    -DSDL_X11=ON -DSDL_WAYLAND=ON -DSDL_KMSDRM=OFF
cmake --build "$work/build" --parallel

mkdir -p "$root/linked-libs/linux-x64"
cp "$work/build/libSDL3.a" "$root/linked-libs/linux-x64/libSDL3.a"
cp "$work/src/LICENSE.txt" "$root/LICENSE.SDL.txt"
ls -l "$root/linked-libs/linux-x64/libSDL3.a"
