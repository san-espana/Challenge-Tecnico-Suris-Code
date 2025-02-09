using SurisAPI.Models;
using SurisAPI.Models.Requests;

namespace SurisAPI.Services.Interfaces
{
    public interface IReservationServiceV2
    {
        Task<List<Reservation>> GetAll();
        Task<List<Reservation>> GetByClient(string client);
        Task<List<Service>> GetAllServices();
        Task AddReservation(ReservationAddRequest request);
        Task<bool> DeleteReservation(int id);
    }
}
