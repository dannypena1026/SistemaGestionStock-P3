# Sistema de Gestion de Stock

Aplicacion web para administrar inventario, usuarios y movimientos de stock.
Este proyecto corresponde al Entregable 3 de Programacion III.

## Descripcion

El sistema permite registrar usuarios, iniciar sesion, administrar productos y
categorias, y procesar entradas y salidas de inventario. Los datos se almacenan
en SQL Server mediante Entity Framework Core.

## Tecnologias utilizadas

- C# y .NET 9
- ASP.NET Core MVC
- Entity Framework Core 9
- SQL Server Express
- Bootstrap y jQuery
- BCrypt.Net

## Estructura del proyecto

```text
Controllers/    Capa de presentacion y acciones MVC
Data/           DbContext y configuracion de acceso a datos
Filtros/        Autenticacion por sesion y autorizacion por roles
Migrations/     Historial de cambios de la base de datos
Models/         Entidades y modelos de formularios
Services/       Logica de autenticacion y movimientos de inventario
Views/          Interfaces Razor organizadas por modulo
wwwroot/        CSS, JavaScript y librerias del cliente
database/       Script SQL alternativo con datos de prueba
```

La solucion sigue una separacion por capas:

1. Presentacion: `Controllers` y `Views`.
2. Logica de negocio: `Services`.
3. Acceso a datos: `Data`, `Models` y Entity Framework Core.

## Modulos implementados

- [x] Autenticacion: login, registro, cierre de sesion y roles.
- [x] Gestion de usuarios: listado, creacion, edicion y eliminacion.
- [x] Inventario: productos, categorias y alertas de stock.
- [x] Movimientos: entradas, salidas e historial.
- [x] Dashboard: indicadores y productos con stock bajo.

### Modulo de autenticacion y usuarios

- Formularios de login y registro.
- Validaciones de campos obligatorios y usuario duplicado.
- Contraseñas almacenadas con BCrypt.
- Persistencia en SQL Server.
- Listado y mantenimiento de usuarios.
- Mensajes de exito y error.

### Modulo de inventario

- Formularios para productos y categorias.
- Validacion de codigos, precios, cantidades y stock.
- Listados con los registros existentes.
- Entradas y salidas persistidas en la base de datos.
- Validacion para impedir salidas mayores al stock disponible.
- Mensajes de confirmacion y error.

## Requisitos previos

- .NET SDK 9
- SQL Server 2022 Express o una instancia compatible
- Git
- Visual Studio 2022 o Visual Studio Code, opcional

Verifique .NET con:

```powershell
dotnet --version
```

## Instalacion y ejecucion

1. Clone el repositorio:

```powershell
git clone https://github.com/dannypena1026/SistemaGestionStock-P3.git
cd SistemaGestionStock-P3
```

2. Restaure paquetes y herramientas:

```powershell
dotnet restore
dotnet tool restore
```

3. Revise la cadena `ConexionSQL` de `appsettings.json`. La configuracion
   incluida utiliza SQL Server Express:

```json
"ConexionSQL": "Server=.\\SQLEXPRESS;Database=SistemaStock;Trusted_Connection=True;TrustServerCertificate=True;"
```

Si su instancia tiene otro nombre, cambie solamente el valor de `Server`.

4. Inicie SQL Server Express:

```powershell
Start-Service MSSQL`$SQLEXPRESS
```

Tambien puede iniciarlo desde **Servicios de Windows**.

5. Cree o actualice la base de datos:

```powershell
dotnet tool run dotnet-ef database update
```

6. Compile y ejecute:

```powershell
dotnet build
dotnet run
```

7. Abra `http://localhost:5258`.

## Script SQL alternativo

Como alternativa a las migraciones, ejecute
`database/SistemaStock.sql` desde SQL Server Management Studio. El script crea
la base `SistemaStock`, tablas, relaciones y datos de prueba.

No aplique el script y las migraciones sobre la misma base vacia al mismo
tiempo. Elija uno de los dos metodos.

## Base de datos

Tablas principales:

- `Roles`
- `Usuarios`
- `Categorias`
- `Productos`
- `Movimientos`

Al iniciar por primera vez mediante migraciones se crean estos accesos:

| Usuario | Contraseña | Rol |
| --- | --- | --- |
| `admin` | `Admin123!` | Admin |
| `usuario` | `Usuario123!` | Usuario |

Comandos utiles:

```powershell
dotnet tool run dotnet-ef migrations list
dotnet tool run dotnet-ef database update
```

## Acceso por roles

| Funcionalidad | Admin | Usuario |
| --- | --- | --- |
| Dashboard | Si | Si |
| Consultar productos | Si | Si |
| Administrar productos | Si | No |
| Administrar categorias | Si | No |
| Administrar usuarios | Si | No |
| Registrar movimientos | Si | Si |

## Verificacion tecnica

Ejecute antes de entregar:

```powershell
dotnet restore
dotnet tool restore
dotnet build --no-restore
dotnet tool run dotnet-ef migrations list
dotnet run --no-build
```

La compilacion debe finalizar con `0 errores`.

## Autores

- Eury Antonio Toribio Reyes - 2024-0093
- Carlos Samuel Castillo - 2024-1306
- Darlin Adriel De Los Santos Castillo - 2023-1738
- Darikson Sanchez - 2024-1049
- Engel Espinosa - 2023-1058

## Repositorio

https://github.com/dannypena1026/SistemaGestionStock-P3
