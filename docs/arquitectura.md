# Arquitectura del laboratorio

## Objetivo

Crear un entorno multiusuario en un VPS donde varios estudiantes puedan trabajar de forma aislada usando Docker.

## Flujo final

```text
Estudiante
   ↓
WireGuard VPN
   ↓
SSH
   ↓
ForceCommand
   ↓
Script personalizado
   ↓
Contenedor Docker del grupo
```

## Distribución

El laboratorio contempla:

* 20 estudiantes
* 5 grupos
* 4 estudiantes por grupo
* 5 contenedores Docker

## Ejemplo

```text
estudiante4 → /usr/local/bin/entrar-estudiante4 → grupo1
```

Ese script ejecuta:

```bash
docker exec -it grupo1 bash
```

## Por qué no usar grupos Linux

Los grupos Linux sirven para controlar permisos de archivos, pero no controlan:

* A qué contenedor entra un usuario
* Qué comandos puede ejecutar por SSH
* El acceso real al sistema host
* El control sobre Docker

## Por qué usar ForceCommand

`ForceCommand` permite que, cuando un usuario entre por SSH, no reciba una shell normal del sistema.

En su lugar, SSH ejecuta un comando obligatorio.

Ejemplo:

```text
Match User estudiante4
    ForceCommand /usr/local/bin/entrar-estudiante4
```

Así el usuario entra directamente a su contenedor.

## Conclusión

```text
Grupos Linux = permisos básicos
Docker + ForceCommand = aislamiento real
```
