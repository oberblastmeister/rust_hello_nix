{ stdenv, cargo, version ? "unknown" }:
stdenv.mkDerivation {
  pname = "hello";
  inherit version;
  nativeBuildInputs = [ cargo ];
  src = ./.;
  buildPhase = ''
    cargo build --release
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp target/release/rust_hello_nix $out/bin/hello
  '';
}
