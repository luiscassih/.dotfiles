{
  lib,
  stdenv,
  fetchzip,
  gnome-shell,
}:

stdenv.mkDerivation rec {
  pname = "gnome-shell-extension-useless-gaps-luix";
  version = "19";

  # src = fetchFromGitHub {
  #   owner = "mipmip";
  #   repo = "gnome-shell-extensions-useless-gaps";
  #   rev = "v${version}";
  #   sha256 = "0000000000000000000000000000000000000000000000000000";
  # };
  src = fetchzip {
    url = "https://extensions.gnome.org/extension-data/useless-gapspimsnel.com.v19.shell-extension.zip";
    sha256 = "14f3936d0981bfca6d2616b4529b0afe1f6b045dca60e97689aff856d06b17b6"
  }

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
