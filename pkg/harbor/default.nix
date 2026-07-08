{
  lib,
  buildPythonApplication,
  fetchFromGitHub,
  nix-update-script,
  python,
  datasets,
  dirhash,
  fastapi,
  filelock,
  httpx,
  jinja2,
  litellm,
  packaging,
  pathspec,
  platformdirs,
  pydantic,
  python-dotenv,
  pyyaml,
  requests,
  rich,
  shortuuid,
  supabase,
  tenacity,
  toml,
  typer,
  uvicorn,
}:

buildPythonApplication (finalAttrs: {
  pname = "harbor";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "harbor-framework";
    repo = "harbor";
    tag = "v${finalAttrs.version}";
    hash = "sha256-SNQuVtOecfHCC/rAYnirV5H47SutjoueUwwCpuolDgw=";
  };

  # Harbor requires uv_build 0.8.x but nixpkgs has 0.10.x
  # Disable pyproject build and install manually
  format = "other";

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/${python.sitePackages}
    cp -r src/harbor $out/${python.sitePackages}/

    # Create proper dist-info for metadata
    mkdir -p $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info
    cat > $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info/METADATA << 'EOFMETA'
    Metadata-Version: 2.1
    Name: harbor
    Version: ${finalAttrs.version}
    EOFMETA

    echo "harbor" > $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info/top_level.txt

    # Create entry_points.txt for console scripts
    cat > $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info/entry_points.txt << 'EOFENTRY'
    [console_scripts]
    harbor = harbor.cli.main:app
    hr = harbor.cli.main:app
    hb = harbor.cli.main:app
    EOFENTRY

    mkdir -p $out/bin

    # Create console script wrappers that call typer app
    cat > $out/bin/harbor << 'EOFSCRIPT'
    #!${python}/bin/python
    # -*- coding: utf-8 -*-
    import re
    import sys
    from harbor.cli.main import app
    if __name__ == '__main__':
        sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', "", sys.argv[0])
        sys.exit(app())
    EOFSCRIPT
    chmod +x $out/bin/harbor

    cat > $out/bin/hr << 'EOFSCRIPT2'
    #!${python}/bin/python
    # -*- coding: utf-8 -*-
    import re
    import sys
    from harbor.cli.main import app
    if __name__ == '__main__':
        sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', "", sys.argv[0])
        sys.exit(app())
    EOFSCRIPT2
        chmod +x $out/bin/hr

    cat > $out/bin/hb << 'EOFSCRIPT3'
    #!${python}/bin/python
    # -*- coding: utf-8 -*-
    import re
    import sys
    from harbor.cli.main import app
    if __name__ == '__main__':
        sys.argv[0] = re.sub(r'(-script\.pyw|\.exe)?$', "", sys.argv[0])
        sys.exit(app())
    EOFSCRIPT3

    chmod +x $out/bin/hb

    runHook postInstall
  '';

  dependencies = [
    datasets
    dirhash
    fastapi
    filelock
    httpx
    jinja2
    litellm
    packaging
    pathspec
    platformdirs
    pydantic
    python-dotenv
    pyyaml
    requests
    rich
    shortuuid
    supabase
    tenacity
    toml
    typer
    uvicorn
  ];

  pythonImportsCheck = [
    "harbor"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Framework for evaluating and improving agents";
    homepage = "https://github.com/harbor-framework/harbor";
    changelog = "https://github.com/harbor-framework/harbor/blob/${finalAttrs.src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "harbor";
  };
})
