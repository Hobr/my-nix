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
  version = "0.16.1";

  src = fetchFromGitHub {
    owner = "harbor-framework";
    repo = "harbor";
    tag = "v${finalAttrs.version}";
    hash = "sha256-liDWcVh689dpgbwVpVgAVkGt92JyGURWX+6wLrcss10=";
  };

  # Harbor requires uv_build 0.8.x but nixpkgs has 0.10.x
  # Disable pyproject build and install manually
  format = "other";

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/${python.sitePackages}
    cp -r src/harbor $out/${python.sitePackages}/

    # Create dist-info for metadata
    mkdir -p $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info
    cat > $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info/METADATA << 'EOF'
    Metadata-Version: 2.1
    Name: harbor
    Version: ${finalAttrs.version}
    EOF

    echo "harbor" > $out/${python.sitePackages}/harbor-${finalAttrs.version}.dist-info/top_level.txt

    mkdir -p $out/bin
    cat > $out/bin/harbor << 'EOF'
    #!${python}/bin/python
    import sys
    from harbor.cli.main import main

    if __name__ == '__main__':
        sys.exit(main())
    EOF

    chmod +x $out/bin/harbor

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
