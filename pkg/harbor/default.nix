{
  lib,
  python3Packages,
  fetchFromGitHub,
  nix-update-script,
}:

python3Packages.buildPythonApplication (finalAttrs: {
  pname = "harbor";
  version = "0.16.1";
  pyproject = true;
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "harbor-framework";
    repo = "harbor";
    tag = "v${finalAttrs.version}";
    hash = "sha256-liDWcVh689dpgbwVpVgAVkGt92JyGURWX+6wLrcss10=";
  };

  build-system = [
    python3Packages.uv-build
  ];

  dependencies = with python3Packages; [
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

  optional-dependencies = with python3Packages; {
    adapter = [
      claude-agent-sdk
    ];
    all = [
      harbor
    ];
    blaxel = [
      blaxel
      dockerfile-parse
    ];
    cloud = [
      harbor
    ];
    computer-1 = [
      anthropic
      google-genai
      openai
    ];
    cua = [
      cua-train
    ];
    cwsandbox = [
      cwsandbox
    ];
    daytona = [
      daytona
    ];
    dspy = [
      dspy
    ];
    e2b = [
      dockerfile-parse
      e2b
    ];
    ec2 = [
      boto3
    ];
    gke = [
      kubernetes
    ];
    islo = [
      dockerfile-parse
      islo
    ];
    langsmith = [
      harbor-langsmith
      langsmith
    ];
    modal = [
      modal
    ];
    novita = [
      dockerfile-parse
      novita-sandbox
    ];
    runloop = [
      dockerfile-parse
      runloop-api-client
    ];
    tensorlake = [
      tensorlake
    ];
    tinker = [
      tinker
      tinker-cookbook
      transformers
    ];
    use-computer = [
      use-computer
    ];
    wandb = [
      cwsandbox
      wandb
    ];
  };

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
