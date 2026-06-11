using SistemaStock.Models;

namespace SistemaStock.Services;

public interface IAuthService
{
    Task<Usuarios?> AuthenticateAsync(string nombreUsuario, string password);
    Task<bool> UsernameExistsAsync(string nombreUsuario);
    Task RegisterAsync(RegistroViewModel model);
}
