with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "stem-env";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    python36
    python36Packages.virtualenv
    python36Packages.pip
    docker
    docker-compose
    kubectl
    postman
    firefox
    awscli2
  ];
}
