{
  pkgs,
  lib,
  stdenv,
  fetchzip,
  gnome-shell,
  nixosTests,
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-useless-gaps";
  version = "19";

  # src = fetchFromGitHub {
  #   owner = "mipmip";
  #   repo = "gnome-shell-extensions-useless-gaps";
  #   rev = "v${version}";
  #   sha256 = "0000000000000000000000000000000000000000000000000000";
  # };
  src = fetchzip {
    url = "https://extensions.gnome.org/extension-data/useless-gapspimsnel.com.v19.shell-extension.zip";
    sha256 = "FLSVajOheBbb2DJ5ZWKgyKmOUoIy0vVfX80EsPyva9I=";
    stripRoot = false;
  };

  nativeBuildInputs = with pkgs; [ buildPackages.glib ];

  buildPhase = ''
    runHook preBuild
    if [ -d schemas ]; then
      glib-compile-schemas --strict schemas
    fi
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions
    cp -r -T . $out/share/gnome-shell/extensions/useless-gaps@pimsnel.com
    runHook postInstall
  '';

  meta = with lib; {
    description = "Useless gaps ver 19 for gnome 48 temporal build by luix";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    homepage = "https://github.com/mipmip/gnome-shell-extension-useless-gaps";
  };

  passthru = {
    extensionUuid = "useless-gaps@pimsnel.com";
    extensionPortalSlug = "useless-gaps";
    tests = {
      gnome-extensions = nixosTests.gnome-extensions;
    };
  };
}
