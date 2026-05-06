# ðŸš€ Laboratorio VPS: WireGuard + Docker + SSH

## ðŸ“Œ DescripciÃ³n

Este proyecto documenta una arquitectura segura para manejar aproximadamente 20 estudiantes dentro de un VPS, usando:

- WireGuard como VPN
- SSH como mÃ©todo de acceso
- ForceCommand para restringir sesiones
- Docker para aislar grupos de trabajo
- Linux como sistema base del servidor

La arquitectura estÃ¡ pensada para 5 grupos de 4 estudiantes.

---

## ðŸ§  Arquitectura general

`	ext
Estudiante â†’ WireGuard VPN â†’ SSH â†’ ForceCommand â†’ Contenedor Docker

`

---

## ðŸ‘¥ DistribuciÃ³n

`	ext
grupo1 â†’ estudiante1, estudiante2, estudiante3, estudiante4
grupo2 â†’ estudiante5, estudiante6, estudiante7, estudiante8
grupo3 â†’ estudiante9, estudiante10, estudiante11, estudiante12
grupo4 â†’ estudiante13, estudiante14, estudiante15, estudiante16
grupo5 â†’ estudiante17, estudiante18, estudiante19, estudiante20
`

---

## ðŸ” Idea principal

El usuario NO entra directamente al sistema operativo del VPS.

Cada estudiante entra por SSH, pero ForceCommand lo redirige automÃ¡ticamente a su contenedor asignado.

---

## âŒ No se usan grupos Linux tradicionales

`	ext
âŒ Usuarios â†’ Grupos Linux â†’ Contenedores
`

La arquitectura real es:

`	ext
âœ” Usuario Linux â†’ ForceCommand â†’ Script personalizado â†’ Contenedor Docker
`

---

## ðŸ›¡ï¸ Ventajas

* Los estudiantes no acceden al host directamente.
* No tienen permisos sobre Docker.
* No pueden crear ni borrar contenedores.
* Cada grupo trabaja en su propio contenedor.
* El acceso SSH puede limitarse solo a la VPN.

---

## ðŸ“‚ Estructura del repositorio

`	ext
README.md
docs/
  arquitectura.md
  paso-a-paso.md
scripts/
  crear_laboratorio.sh
`

---

## âš ï¸ Nota importante

Los usuarios estudiantes nunca deben agregarse al grupo docker, porque eso les darÃ­a privilegios muy altos sobre el VPS.

`ash
usermod -aG docker estudiante1
`

Eso NO debe hacerse.

---

## ðŸ‘¨â€ðŸ’» Autor

Proyecto de laboratorio para administraciÃ³n de servidores, Docker, VPN y manejo de usuarios Linux.
