# Paso a paso del laboratorio

## 1. Preparar el VPS

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io ufw curl nano
sudo systemctl enable --now docker
```

## 2. Ejecutar script de usuarios y contenedores

```bash
sudo chmod +x scripts/crear_laboratorio.sh
sudo ./scripts/crear_laboratorio.sh
```

Esto crea:

```text
5 contenedores Docker
20 usuarios Linux
Scripts personalizados de entrada
Configuración SSH con ForceCommand
```

## 3. Instalar WireGuard

```bash
wget -O wireguard.sh https://get.vpnsetup.net/wg
sudo bash wireguard.sh
```

Opciones recomendadas:

```text
Puerto: 51820
DNS: 1.1.1.1
Primer cliente: admin
```

## 4. Crear clientes VPN

Ejecutar:

```bash
sudo bash wireguard.sh
```

Seleccionar:

```text
Add a new client
```

Crear:

```text
estudiante1
estudiante2
...
estudiante20
```

## 5. Probar conexión

Desde la PC del estudiante:

```bash
ssh estudiante1@10.66.66.1
```

Debe entrar directo al contenedor asignado.

## 6. Restringir SSH solo a la VPN

Haz esto solo después de probar que la VPN funciona:

```bash
sudo ufw allow 51820/udp
sudo ufw allow from 10.66.66.0/24 to any port 22
sudo ufw deny 22
sudo ufw enable
```

## 7. Endurecimiento recomendado

Editar SSH:

```bash
sudo nano /etc/ssh/sshd_config
```

Configurar:

```text
PasswordAuthentication no
PermitRootLogin no
```

Reiniciar SSH:

```bash
sudo systemctl restart ssh
```

## 8. Acceso del administrador

El administrador debe tener un usuario separado:

```bash
adduser admin
usermod -aG sudo admin
```

El usuario admin NO debe tener ForceCommand.

Ejemplo de acceso:

```bash
ssh admin@10.66.66.1
```

## Errores comunes

```text
No probar la VPN antes de cerrar SSH público
Meter estudiantes al grupo docker
Usar Match User *
No crear usuario admin separado
```
