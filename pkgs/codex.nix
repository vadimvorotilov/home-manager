{
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation rec {
  pname = "codex";
  version = "0.105.0";

  src = fetchurl {
    url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-eNHDgV1+mNW9QwXtVedOm2RsOHiug0eSGbCu0ow09HM=";
  };

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    tar -xzf "$src"
    install -Dm755 codex-x86_64-unknown-linux-musl "$out/bin/codex"
    runHook postInstall
  '';
}
