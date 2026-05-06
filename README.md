# Laboratorio VPS: WireGuard + Docker + SSH

Descripción

Documentación de una arquitectura segura para manejar aproximadamente 20 estudiantes dentro de un VPS, usando:

- WireGuard como VPN
- SSH como metodo de acceso
- ForceCommand para restringir sesiones
- Docker para aislar grupos de trabajo
- Linux como sistema base del servidor

La arquitectura esta pensada para 5 grupos de 4 estudiantes.



Arquitectura general

`	ext
Estudiante → WireGuard VPN → SSH → ForceCommand → Contenedor Docker

`

---

## 👥 Distribución

```text
grupo1 → estudiante1, estudiante2, estudiante3, estudiante4
grupo2 → estudiante5, estudiante6, estudiante7, estudiante8
grupo3 → estudiante9, estudiante10, estudiante11, estudiante12
grupo4 → estudiante13, estudiante14, estudiante15, estudiante16
grupo5 → estudiante17, estudiante18, estudiante19, estudiante20
```

---

## 🔐 Idea principal

El usuario NO entra directamente al sistema operativo del VPS.

Cada estudiante entra por SSH, pero `ForceCommand` lo redirige automáticamente a su contenedor asignado.

---

## ❌ No se usan grupos Linux tradicionales

```text
❌ Usuarios → Grupos Linux → Contenedores
```

La arquitectura real es:

```text
✔ Usuario Linux → ForceCommand → Script personalizado → Contenedor Docker
```


## 🛡️ Ventajas

* Los estudiantes no acceden al host directamente.
* No tienen permisos sobre Docker.
* No pueden crear ni borrar contenedores.
* Cada grupo trabaja en su propio contenedor.
* El acceso SSH puede limitarse solo a la VPN.

---

## 📂 Estructura del repositorio

```text
README.md
docs/
  arquitectura.md
  paso-a-paso.md
scripts/
  crear_laboratorio.sh
```

---

## ⚠️ Nota importante

Los usuarios estudiantes nunca deben agregarse al grupo `docker`, porque eso les daría privilegios muy altos sobre el VPS.

```bash
usermod -aG docker estudiante1
```

Eso NO debe hacerse.

---


## 👨‍💻 Autor

Proyecto de laboratorio para administración de servidores, Docker, VPN y manejo de usuarios Linux.
