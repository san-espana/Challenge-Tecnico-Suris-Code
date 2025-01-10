using SurisAPI.Models;
using SurisAPI.Models.Requests;

namespace SurisAPI.Services.Interfaces
{
    public interface IReservationService
    {
        public List<Reservation> GetAll();
        public List<Reservation> GetByClient(string client);
        public List<Service> GetAllServices();
        public void AddReservation(ReservationAddRequest request);
    }
}
