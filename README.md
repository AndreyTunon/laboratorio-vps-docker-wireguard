# ðŸš€ Laboratorio VPS: WireGuard + Docker + SSH

## ðŸ“Œ DescripciÃ³n
Sistema multiusuario con aislamiento usando Docker, controlado por SSH y protegido con VPN.

---

## ðŸ§  Arquitectura


---

## ðŸ” Flujo

1. Usuario se conecta a VPN
2. Accede por SSH
3. Es redirigido automÃ¡ticamente
4. Entra a su contenedor asignado

---

## â— Importante

NO se usan grupos Linux tradicionales.

âŒ Usuarios â†’ Grupos â†’ Contenedores  
âœ” Usuario â†’ Script â†’ Contenedor

---

## ðŸ³ TecnologÃ­as

- Docker
- WireGuard
- SSH (ForceCommand)
- Linux

---

## ðŸ“‚ Estructura


---

## âš ï¸ Seguridad

- Sin acceso al host
- Sin acceso a Docker
- Aislamiento por contenedor

---

## ðŸ”¥ Autor

Proyecto de laboratorio de ciberseguridad
