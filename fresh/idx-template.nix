/*
 Copyright 2024 Google LLC

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

{ pkgs, styling ? "tailwind", docker ? true, vscode ? true, ... }: {
  packages = [
    pkgs.deno
  ];
  bootstrap = ''
    mkdir "$out"
    deno run -A -r https://fresh.deno.dev "$out" ${if docker then "--docker" else "" } ${if vscode then "--vscode" else "" } --${styling}
    mkdir -p "$out/.idx/"
    cp -rf ${./dev.nix} "$out/.idx/dev.nix"
    chmod -R +w "$out"
  '';
}