# Niksi devcontainer

## Example

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    niksi-devcontainer.url = "github:niksi-aalto/niksi-devcontainer";
  };
  outputs = {
    self,
    nixpkgs,
    niksi-devcontainer,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    packages.x86_64-linux.default = niksi-devcontainer.lib.mkDevcontainer {
      inherit pkgs;
      name = "hello-world";
      paths = with pkgs; [hello];
    };
  };
}
```
