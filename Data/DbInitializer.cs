using Microsoft.EntityFrameworkCore;
using SistemaStock.Models;

namespace SistemaStock.Data;

public static class DbInitializer
{
    public static async Task InitializeAsync(SistemaStockContext context)
    {
        if (!await context.Roles.AnyAsync())
        {
            context.Roles.AddRange(
                new Rol { Nombre = "Admin" },
                new Rol { Nombre = "Usuario" });
            await context.SaveChangesAsync();
        }

        if (!await context.Categorias.AnyAsync())
        {
            context.Categorias.AddRange(
                new Categoria { Nombre = "Electronica" },
                new Categoria { Nombre = "Herramientas" },
                new Categoria { Nombre = "Oficina" });
        }

        if (!await context.Usuarios.AnyAsync())
        {
            var adminRolId = await context.Roles
                .Where(r => r.Nombre == "Admin")
                .Select(r => r.RolId)
                .SingleAsync();
            var usuarioRolId = await context.Roles
                .Where(r => r.Nombre == "Usuario")
                .Select(r => r.RolId)
                .SingleAsync();

            context.Usuarios.AddRange(
                new Usuarios
                {
                    NombreUsuario = "admin",
                    Password = BCrypt.Net.BCrypt.HashPassword("Admin123!"),
                    Nombre = "Administrador",
                    RolId = adminRolId,
                    Activo = true
                },
                new Usuarios
                {
                    NombreUsuario = "usuario",
                    Password = BCrypt.Net.BCrypt.HashPassword("Usuario123!"),
                    Nombre = "Usuario de prueba",
                    RolId = usuarioRolId,
                    Activo = true
                });
        }

        await context.SaveChangesAsync();
    }
}
