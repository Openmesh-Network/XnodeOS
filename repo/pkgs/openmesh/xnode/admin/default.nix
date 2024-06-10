{ pkgs, lib, ... }:

pkgs.python3Packages.buildPythonPackage rec {
  pname = "xnode-admin";
  version = "0.0.0";
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "Openmesh-Network";
    repo = pname;
    rev = "e5fd838e72ec7cdd6325c0976555f5976810e7ad";
    sha256 = "101pli1mzw9gqcvb3j5s6yvf4bzl0lxhbkczldigfbdnyjfdjcar";
  };

  nativeBuildInputs = [
    pkgs.python3Packages.hatchling
  ];

  propagatedBuildInputs = with pkgs.python3Packages; [
    gitpython
    psutil
    requests
  ];

  meta = with lib; {
      homepage = "https://openmesh.network/";
      description = "Agent service for Xnode reconfiguration and management";
      mainProgram = "openmesh-xnode-admin";
      #license = with licenses; [ x ];
      maintainers = with maintainers; [ harrys522 j-openmesh ];
    };
}
