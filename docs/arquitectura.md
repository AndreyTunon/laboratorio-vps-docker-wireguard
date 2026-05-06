
# Arquitectura del laboratorio

## Objetivo

Crear un entorno multiusuario en un VPS donde varios estudiantes puedan trabajar de forma aislada usando Docker.

## Flujo final

`	ext
Estudiante
   â†“
WireGuard VPN
   â†“
SSH
   â†“
ForceCommand
   â†“
Script personalizado
   â†“
Contenedor Docker del grupo
`

## DistribuciÃ³n

El laboratorio contempla:

* 20 estudiantes
* 5 grupos
* 4 estudiantes por grupo
* 5 contenedores Docker

## Ejemplo

`	ext
estudiante4 â†’ /usr/local/bin/entrar-estudiante4 â†’ grupo1
`

Ese script ejecuta:

`ash
docker exec -it grupo1 bash
`

## Por quÃ© no usar grupos Linux

Los grupos Linux sirven para controlar permisos de archivos, pero no controlan:

* A quÃ© contenedor entra un usuario
* QuÃ© comandos puede ejecutar por SSH
* El acceso real al sistema host
* El control sobre Docker

## Por quÃ© usar ForceCommand

ForceCommand permite que, cuando un usuario entre por SSH, no reciba una shell normal del sistema.

En su lugar, SSH ejecuta un comando obligatorio.

Ejemplo:

`	ext
Match User estudiante4
    ForceCommand /usr/local/bin/entrar-estudiante4
`

AsÃ­ el usuario entra directamente a su contenedor.

## ConclusiÃ³n

`	ext
Grupos Linux = permisos bÃ¡sicos
Docker + ForceCommand = aislamiento real
`

