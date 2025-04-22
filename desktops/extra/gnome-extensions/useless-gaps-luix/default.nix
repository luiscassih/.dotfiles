{
  lib,
  stdenv,
  fetchFromGitHub,
  gnome-shell,
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-useless-gaps-luix";
  version = "19";

  src = fetchFromGitHub {
    owner = "mipmip";
    repo = "gnome-shell-extensions-useless-gaps";
    rev = "v${version}";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  passthru = {
    extensionUuid = "useless-gaps@luisc.dev";
    extensionPortalSlug = "useless-gaps";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/gnome-shell/extensions
    cp -r "useless-gaps@luisc.dev" $out/share/gnome-shell/extensions
    runHook postInstall
  '';

  meta = with lib; {
    description = "Useless gaps ver 19 for gnome 48 temporal build by luix";
    license = licenses.gpl3;
    maintainers = with maintainers; [ ];
    homepage = "https://github.com/mipmip/gnome-shell-extension-useless-gaps";
  };
}
