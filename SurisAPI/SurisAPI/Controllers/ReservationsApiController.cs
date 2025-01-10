using Microsoft.AspNetCore.Mvc;
using SurisAPI.Models;
using SurisAPI.Models.Requests;
using SurisAPI.Services.Interfaces;

namespace SurisAPI.Controllers
{
    [Route("api/reservations")]
    [ApiController]
    public class ReservationsApiController : ControllerBase
    {
        private IReservationService _reservationService;

        public ReservationsApiController(IReservationService reservationService)
        {
            _reservationService = reservationService;
        }

        [HttpGet]
        public IActionResult GetAllReservations()
        {
            try
            {
                List<Reservation> reservations = _reservationService.GetAll();
                return Ok(reservations);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener las reservas: {ex.Message}");
            }
        }

        [HttpGet("client/{client}")]
        public IActionResult GetReservationsbyClient(string client)
        {
            try
            {
                List<Reservation> reservations = _reservationService.GetByClient(client);
                return Ok(reservations);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener las reservas: {ex.Message}");
            }
        }

        [HttpGet("services")]
        public IActionResult GetAllServices()
        {
            try
            {
                List<Service> services = _reservationService.GetAllServices();
                return Ok(services);
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al obtener los servicios: {ex.Message}");
            }
        }

        [HttpPost]
        public IActionResult AddNewReservation([FromBody] ReservationAddRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            try
            {
                _reservationService.AddReservation(request);
                return StatusCode(201, new { message = "Reservation created successfully." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Error al agregar la reserva: {ex.Message}");
            }
        }

    }
}
