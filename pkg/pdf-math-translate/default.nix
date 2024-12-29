{
  lib,
  python3,
  fetchFromGitHub,
  azure-ai-translation-text,
  backend ? false,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "pdf-math-translate";
  version = "1.8.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Byaidu";
    repo = "PDFMathTranslate";
    rev = "v${version}";
    hash = "sha256-WvPdvsKorEnHqf+q26+0VbAEriv6CI1UsNhYPRcMu+A=";
  };

  build-system = with python3.pkgs; [
    hatchling
  ];

  dependencies =
    with python3.pkgs;
    [
      azure-ai-translation-text
      deepl
      gradio
      gradio-pdf
      huggingface-hub
      numpy
      ollama
      onnx
      onnxruntime
      openai
      opencv-python-headless
      pdfminer-six
      pymupdf
      requests
      tenacity
      tencentcloud-sdk-python
      tqdm
    ]
    ++ lib.optional backend [
      celery
      flask
      redis
    ];

  pythonImportsCheck = [
    "pdf2zh"
  ];

  meta = {
    description = "PDF scientific paper translation with preserved formats - 基于 AI 完整保留排版的 PDF 文档全文双语翻译，支持 Google/DeepL/Ollama/OpenAI 等服务，提供 CLI/GUI/Docker";
    homepage = "https://github.com/Byaidu/PDFMathTranslate";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "pdf-math-translate";
  };
}
