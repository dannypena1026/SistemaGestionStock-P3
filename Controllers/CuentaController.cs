using Microsoft.AspNetCore.Mvc;
using SistemaStock.Models;
using SistemaStock.Services;

namespace SistemaStock.Controllers;

public class CuentaController : Controller
{
    private readonly IAuthService _authService;

    public CuentaController(IAuthService authService)
    {
        _authService = authService;
    }

    public IActionResult Login()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Login(LoginViewModel model)
    {
        if (ModelState.IsValid)
        {
            var usuario = await _authService.AuthenticateAsync(
                model.NombreUsuario!,
                model.Password!);

            if (usuario != null)
            {
                HttpContext.Session.SetString("UsuarioId", usuario.UsuarioId.ToString());
                HttpContext.Session.SetString("NombreUsuario", usuario.NombreUsuario!);
                HttpContext.Session.SetString("Nombre", usuario.Nombre!);
                HttpContext.Session.SetString("RolId", usuario.RolId.ToString());
                return RedirectToAction("Index", "Home");
            }

            ModelState.AddModelError("", "Usuario o contraseña incorrectos");
        }

        return View(model);
    }

    public IActionResult Registro()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Registro(RegistroViewModel model)
    {
        if (ModelState.IsValid)
        {
            if (await _authService.UsernameExistsAsync(model.NombreUsuario!))
            {
                ModelState.AddModelError("NombreUsuario", "Este nombre de usuario ya existe");
                return View(model);
            }

            await _authService.RegisterAsync(model);
            return RedirectToAction("Login");
        }

        return View(model);
    }

    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Login");
    }

    public IActionResult Denegado()
    {
        return View();
    }
}
