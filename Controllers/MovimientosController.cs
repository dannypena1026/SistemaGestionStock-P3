using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SistemaStock.Data;
using SistemaStock.Filters;
using SistemaStock.Models;
using SistemaStock.Services;

namespace SistemaStock.Controllers;

[SessionAuthFilter]
public class MovimientosController : Controller
{
    private readonly SistemaStockContext _context;
    private readonly IStockService _stockService;

    public MovimientosController(SistemaStockContext context, IStockService stockService)
    {
        _context = context;
        _stockService = stockService;
    }

    public async Task<IActionResult> Index()
    {
        var movimientos = await _context.Movimientos
            .Include(m => m.Producto)
            .Include(m => m.Usuario)
            .OrderByDescending(m => m.Fecha)
            .ToListAsync();

        ViewBag.Productos = await _context.Productos
            .Where(p => p.Activo)
            .ToListAsync();

        return View(movimientos);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public Task<IActionResult> Entrada([Bind("ProductoId,Cantidad,Observacion")] Movimiento movimiento)
    {
        return RegistrarMovimiento(movimiento, esEntrada: true);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public Task<IActionResult> Salida([Bind("ProductoId,Cantidad,Observacion")] Movimiento movimiento)
    {
        return RegistrarMovimiento(movimiento, esEntrada: false);
    }

    private async Task<IActionResult> RegistrarMovimiento(Movimiento movimiento, bool esEntrada)
    {
        ModelState.Remove("Tipo");
        ModelState.Remove("Producto");
        ModelState.Remove("Usuario");

        if (ModelState.IsValid)
        {
            var usuarioId = int.Parse(HttpContext.Session.GetString("UsuarioId")!);
            var resultado = esEntrada
                ? await _stockService.RegisterEntryAsync(movimiento, usuarioId)
                : await _stockService.RegisterExitAsync(movimiento, usuarioId);

            TempData[resultado.Success ? "Success" : "Error"] = resultado.Message;
        }
        else
        {
            TempData["Error"] = string.Join(", ", ModelState.Values
                .SelectMany(v => v.Errors)
                .Select(e => e.ErrorMessage));
        }

        return RedirectToAction(nameof(Index));
    }
}
