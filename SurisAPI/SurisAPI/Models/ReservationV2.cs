namespace SurisAPI.Models
{
    public class ReservationV2
    {
        public int Id { get; set; }
        public int ServiceId { get; set; }
        public Service? Service { get; set; }
        public DateTime DateTime { get; set; }
        public string Client { get; set; } = string.Empty;
    }
}
