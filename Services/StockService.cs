using SistemaStock.Data;
using SistemaStock.Models;

namespace SistemaStock.Services;

public class StockService : IStockService
{
    private readonly SistemaStockContext _context;

    public StockService(SistemaStockContext context)
    {
        _context = context;
    }

    public Task<(bool Success, string Message)> RegisterEntryAsync(
        Movimiento movimiento,
        int usuarioId)
    {
        return RegisterMovementAsync(movimiento, usuarioId, "Entrada");
    }

    public Task<(bool Success, string Message)> RegisterExitAsync(
        Movimiento movimiento,
        int usuarioId)
    {
        return RegisterMovementAsync(movimiento, usuarioId, "Salida");
    }

    private async Task<(bool Success, string Message)> RegisterMovementAsync(
        Movimiento movimiento,
        int usuarioId,
        string tipo)
    {
        var producto = await _context.Productos.FindAsync(movimiento.ProductoId);
        if (producto == null)
        {
            return (false, "Producto no encontrado.");
        }

        if (tipo == "Salida" && movimiento.Cantidad > producto.Stock)
        {
            return (false, $"Stock insuficiente. Stock actual: {producto.Stock} unidades.");
        }

        movimiento.Tipo = tipo;
        movimiento.UsuarioId = usuarioId;
        movimiento.StockAnterior = producto.Stock;
        movimiento.StockNuevo = tipo == "Entrada"
            ? producto.Stock + movimiento.Cantidad
            : producto.Stock - movimiento.Cantidad;
        movimiento.Fecha = DateTime.Now;

        producto.Stock = movimiento.StockNuevo;
        _context.Movimientos.Add(movimiento);
        await _context.SaveChangesAsync();

        return (true, $"{tipo} registrada. Stock actualizado a {movimiento.StockNuevo} unidades.");
    }
}
