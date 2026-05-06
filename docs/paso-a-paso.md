
# Paso a paso del laboratorio

## 1. Preparar el VPS

`ash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io ufw curl nano
sudo systemctl enable --now docker
`

## 2. Ejecutar script de usuarios y contenedores

`ash
sudo chmod +x scripts/crear_laboratorio.sh
sudo ./scripts/crear_laboratorio.sh
`

Esto crea:

`	ext
5 contenedores Docker
20 usuarios Linux
Scripts personalizados de entrada
ConfiguraciÃ³n SSH con ForceCommand
`

## 3. Instalar WireGuard

`ash
wget -O wireguard.sh https://get.vpnsetup.net/wg
sudo bash wireguard.sh
`

Opciones recomendadas:

`	ext
Puerto: 51820
DNS: 1.1.1.1
Primer cliente: admin
`

## 4. Crear clientes VPN

Ejecutar:

`ash
sudo bash wireguard.sh
`

Seleccionar:

`	ext
Add a new client
`

Crear:

`	ext
estudiante1
estudiante2
...
estudiante20
`

## 5. Probar conexiÃ³n

Desde la PC del estudiante:

`ash
ssh estudiante1@10.66.66.1
`

Debe entrar directo al contenedor asignado.

## 6. Restringir SSH solo a la VPN

Haz esto solo despuÃ©s de probar que la VPN funciona:

`ash
sudo ufw allow 51820/udp
sudo ufw allow from 10.66.66.0/24 to any port 22
sudo ufw deny 22
sudo ufw enable
`

## 7. Endurecimiento recomendado

Editar SSH:

`ash
sudo nano /etc/ssh/sshd_config
`

Configurar:

`	ext
PasswordAuthentication no
PermitRootLogin no
`

Reiniciar SSH:

`ash
sudo systemctl restart ssh
`

## 8. Acceso del administrador

El administrador debe tener un usuario separado:

`ash
adduser admin
usermod -aG sudo admin
`

El usuario admin NO debe tener ForceCommand.

Ejemplo de acceso:

`ash
ssh admin@10.66.66.1
`

## Errores comunes

`	ext
No probar la VPN antes de cerrar SSH pÃºblico
Meter estudiantes al grupo docker
Usar Match User *
No crear usuario admin separado
`

