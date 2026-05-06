# subir-docs-github.ps1

$RepoName = "laboratorio-vps-docker-wireguard"
$CommitMsg = "Actualizar documentacion del proyecto"

Write-Host "[+] Verificando carpeta actual..."
Write-Host "Ruta actual: $(Get-Location)"

if (-not (Test-Path ".git")) {
    Write-Host "[+] Inicializando Git..."
    git init
    git branch -M main
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Host "[!] GitHub CLI no esta instalado o no esta en PATH."
    Write-Host "Instalalo con:"
    Write-Host "winget install --id GitHub.cli -e"
    exit
}

Write-Host "[+] Verificando login de GitHub..."
gh auth status
if ($LASTEXITCODE -ne 0) {
    gh auth login
}

Write-Host "[+] Agregando documentacion..."
git add .

$Status = git status --porcelain

if ([string]::IsNullOrWhiteSpace($Status)) {
    Write-Host "[!] No hay cambios nuevos para subir."
    exit
}

Write-Host "[+] Creando commit..."
git commit -m $CommitMsg

Write-Host "[+] Verificando remoto origin..."
git remote get-url origin 2>$null

if ($LASTEXITCODE -ne 0) {
    Write-Host "[+] No existe remoto origin. Creando repo en GitHub..."

    gh repo create $RepoName --public --source=. --remote=origin --push

    Write-Host "[+] Repositorio creado y subido."
    gh repo view --web
    exit
}

Write-Host "[+] Subiendo cambios a GitHub..."
git push origin main

Write-Host "[+] Listo. Documentacion actualizada en GitHub."
gh repo view --web