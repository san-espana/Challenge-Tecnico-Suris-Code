
namespace SurisAPI.Models
{
    public class Reservation
    {
        public int Id { get; set; }
        public Service? Service { get; set; }
        public DateTime DateTime { get; set; }
        public string Client { get; set; } = string.Empty;
    }
}
