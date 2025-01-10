using System.ComponentModel.DataAnnotations;

namespace SurisAPI.Models.Requests
{
    public class ReservationAddRequest
    {
        [Required, StringLength(50, MinimumLength = 4)]
        public string Client { get; set; } = string.Empty;
        [Required]
        public int ServiceId { get; set; }
        [Required]
        public DateTime DateTime { get; set; }
    }
}
