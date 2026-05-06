$RepoName = "laboratorio-vps-docker-wireguard"

Write-Host "[+] Creando estructura..."

mkdir $RepoName -ErrorAction SilentlyContinue
cd $RepoName

mkdir scripts -ErrorAction SilentlyContinue
mkdir docs -ErrorAction SilentlyContinue

Write-Host "[+] Creando README..."

@"
# 🚀 Laboratorio VPS: WireGuard + Docker + SSH

## 📌 Descripción
Sistema multiusuario con aislamiento usando Docker, controlado por SSH y protegido con VPN.

---

## 🧠 Arquitectura


---

## 🔁 Flujo

1. Usuario se conecta a VPN
2. Accede por SSH
3. Es redirigido automáticamente
4. Entra a su contenedor asignado

---

## ❗ Importante

NO se usan grupos Linux tradicionales.

❌ Usuarios → Grupos → Contenedores  
✔ Usuario → Script → Contenedor

---

## 🐳 Tecnologías

- Docker
- WireGuard
- SSH (ForceCommand)
- Linux

---

## 📂 Estructura


---

## ⚠️ Seguridad

- Sin acceso al host
- Sin acceso a Docker
- Aislamiento por contenedor

---

## 🔥 Autor

Proyecto de laboratorio de ciberseguridad
"@ | Out-File README.md -Encoding utf8

Write-Host "[+] Copiando archivos..."

Copy-Item ../crear_laboratorio.sh ./scripts/ -ErrorAction SilentlyContinue
Copy-Item ../vps.html ./docs/ -ErrorAction SilentlyContinue

Write-Host "[+] Inicializando Git..."

git init
git branch -M main
git add .
git commit -m "Initial commit - laboratorio VPS"

Write-Host "[+] Verificando GitHub CLI..."

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    winget install --id GitHub.cli -e
}

gh auth login

Write-Host "[+] Creando repo en GitHub..."

gh repo create $RepoName --public --source=. --remote=origin --push

gh repo view --web

Write-Host "[+] LISTO 🚀"