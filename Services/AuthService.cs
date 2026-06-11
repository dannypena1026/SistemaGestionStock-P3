using Microsoft.EntityFrameworkCore;
using SistemaStock.Data;
using SistemaStock.Models;

namespace SistemaStock.Services;

public class AuthService : IAuthService
{
    private readonly SistemaStockContext _context;

    public AuthService(SistemaStockContext context)
    {
        _context = context;
    }

    public async Task<Usuarios?> AuthenticateAsync(string nombreUsuario, string password)
    {
        var usuario = await _context.Usuarios
            .FirstOrDefaultAsync(u => u.NombreUsuario == nombreUsuario && u.Activo);

        return usuario != null && BCrypt.Net.BCrypt.Verify(password, usuario.Password)
            ? usuario
            : null;
    }

    public Task<bool> UsernameExistsAsync(string nombreUsuario)
    {
        return _context.Usuarios.AnyAsync(u => u.NombreUsuario == nombreUsuario);
    }

    public async Task RegisterAsync(RegistroViewModel model)
    {
        var usuario = new Usuarios
        {
            NombreUsuario = model.NombreUsuario,
            Password = BCrypt.Net.BCrypt.HashPassword(model.Password),
            Nombre = model.Nombre,
            RolId = 2,
            Activo = true
        };

        _context.Usuarios.Add(usuario);
        await _context.SaveChangesAsync();
    }
}
