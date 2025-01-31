{
  outputs = _: {
    lib.mkDevcontainer = {
      pkgs,
      name,
      tag ? "latest",
      fromImage ?
        pkgs.dockerTools.pullImage {
          imageName = "mcr.microsoft.com/devcontainers/base";
          imageDigest = "sha256:003d94e845d73ea81a9245edd90a4edf852ff19e5b9a7992692538ba6295a9be";
          sha256 = "sha256-WyoR/ALyynMeDTcfnc2iIpVSuHU1U8+NI+R8QVEDL4A=";
        },
      paths ? [],
      pathsToLink ? ["/bin" "/usr"],
    }: let
      username = "niksi";
    in
      pkgs.dockerTools.buildImage {
        inherit name tag fromImage;
        diskSize = 1024 * 2;
        copyToRoot = pkgs.buildEnv {
          name = "env";
          paths = paths ++ [pkgs.dockerTools.binSh];
          inherit pathsToLink;
        };
        runAsRoot = ''
          #!${pkgs.runtimeShell}
          ${pkgs.dockerTools.shadowSetup}
          useradd -m -g users -s /usr/bin/bash ${username}
          mkdir /workspaces
          chown -R ${username}:users /workspaces
        '';
      };
  };
}
