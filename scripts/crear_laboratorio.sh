#!/bin/bash

set -e

IMAGE="ubuntu:22.04"
TOTAL_GRUPOS=5
ESTUDIANTES_POR_GRUPO=4

echo "[+] Creando contenedores por grupo..."

for grupo in $(seq 1 $TOTAL_GRUPOS); do
container="grupo$grupo"

```
if docker ps -a --format '{{.Names}}' | grep -q "^${container}$"; then
    echo "[!] El contenedor $container ya existe. Saltando..."
else
    docker run -dit \
      --name "$container" \
      --hostname "$container" \
      --restart unless-stopped \
      --memory="512m" \
      --cpus="0.5" \
      "$IMAGE" bash

    docker exec "$container" apt update
    docker exec "$container" apt install -y sudo nano vim curl iputils-ping net-tools
fi
```

done

echo "[+] Creando usuarios Linux y scripts de entrada..."

contador=1

for grupo in $(seq 1 $TOTAL_GRUPOS); do
container="grupo$grupo"

```
for n in $(seq 1 $ESTUDIANTES_POR_GRUPO); do
    user="estudiante$contador"
    script="/usr/local/bin/entrar-$user"

    if id "$user" &>/dev/null; then
        echo "[!] El usuario $user ya existe. Saltando creaciÃ³n..."
    else
        adduser --disabled-password --gecos "" "$user"
        echo "$user:ClaveTemporal123!" | chpasswd
    fi

    cat > "$script" <<EOF
```

#!/bin/bash
echo "Entrando al contenedor asignado: $container"
echo "Usuario Linux: $user"
echo "Para salir del contenedor escribe: exit"
docker exec -it "$container" bash
EOF

```
    chmod +x "$script"

    contador=$((contador+1))
done
```

done

echo "[+] Configurando SSH con ForceCommand..."

SSHD_CUSTOM="/etc/ssh/sshd_config.d/laboratorio_docker.conf"

cat > "$SSHD_CUSTOM" <<EOF

# Laboratorio Docker - 5 grupos / 20 estudiantes

EOF

contador=1

for grupo in $(seq 1 $TOTAL_GRUPOS); do
for n in $(seq 1 $ESTUDIANTES_POR_GRUPO); do
user="estudiante$contador"
script="/usr/local/bin/entrar-$user"

```
    cat >> "$SSHD_CUSTOM" <<EOF
```

Match User $user
ForceCommand $script
AllowTcpForwarding no
X11Forwarding no
PermitTunnel no
PermitTTY yes

EOF

```
    contador=$((contador+1))
done
```

done

echo "[+] Validando configuraciÃ³n SSH..."

sshd -t

echo "[+] Reiniciando SSH..."

systemctl restart ssh || systemctl restart sshd

echo "[+] Listo."
echo "Usuarios creados: estudiante1 hasta estudiante20"
echo "Contenedores creados: grupo1 hasta grupo5"
echo "ContraseÃ±a temporal: ClaveTemporal123!"
echo "IMPORTANTE: luego cambia a llaves SSH y desactiva PasswordAuthentication."
