using SistemaStock.Models;

namespace SistemaStock.Services;

public interface IStockService
{
    Task<(bool Success, string Message)> RegisterEntryAsync(Movimiento movimiento, int usuarioId);
    Task<(bool Success, string Message)> RegisterExitAsync(Movimiento movimiento, int usuarioId);
}
