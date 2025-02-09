using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SurisAPI.Models;
using SurisAPI.Models.Requests;
using SurisAPI.Services.Interfaces;

namespace SurisAPI.Controllers
{
    [Route("api/v2/reservations")]
    [ApiController]
    public class ReservationsApiControllerV2 : ControllerBase
    {
        private IReservationServiceV2 _reservationServiceV2;

        public ReservationsApiControllerV2(IReservationServiceV2 reservationServiceV2)
        {
            _reservationServiceV2 = reservationServiceV2;
        }

        [HttpGet]
        public async Task<IActionResult> GetAllReservations()
        {
            try
            {
                List<Reservation> reservations = await _reservationServiceV2.GetAll();

                if (reservations == null || reservations.Count == 0) return NotFound(new { message = "No se encontraron Reservas." });

                return Ok(reservations);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener las Reservas: {ex.Message}");
            }
        }

        [HttpGet("client/{client}")]
        public async Task<IActionResult> GetReservationsbyClient(string client)
        {
            try
            {
                List<Reservation> reservations = await _reservationServiceV2.GetByClient(client);

                if (reservations == null || reservations.Count == 0) return NotFound(new { message = "No se encontraron Reservas." });

                return Ok(reservations);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener las Reservas: {ex.Message}");
            }
        }

        [HttpGet("services")]
        public async Task<IActionResult> GetAllServices()
        {
            try
            {
                List<Service> services = await _reservationServiceV2.GetAllServices();

                if (services == null || services.Count == 0) return NotFound(new { message = "No se encontraron Servicios." });

                return Ok(services);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener los Servicios: {ex.Message}");
            }
        }

        [HttpPost]
        public async Task<IActionResult> AddNewReservation([FromBody] ReservationAddRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                await _reservationServiceV2.AddReservation(request);
                return StatusCode(201, new { message = "Reserva creada." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al agregar la Reserva: {ex.Message}");
            }
        }

        [HttpDelete("{reservationId}")]
        public async Task<IActionResult> DeleteReservation(int reservationId)
        {
            try
            {
                bool isDeleted = await _reservationServiceV2.DeleteReservation(reservationId);

                if (!isDeleted)
                {
                    return NotFound(new { message = "No se encontraron Reservas." });
                }

                return Ok(new { message = "Reserva borrada." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = $"Error al borrar la Reserva: {ex.Message}" });
            }
        }

    }
}
