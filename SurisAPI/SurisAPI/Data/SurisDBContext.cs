using Microsoft.EntityFrameworkCore;
using SurisAPI.Models;

namespace SurisAPI.Data
{
    public class SurisDBContext : DbContext
    {
        public SurisDBContext(DbContextOptions<SurisDBContext> options) : base(options) { }

        public DbSet<ReservationV2> Reservations { get; set; }
        public DbSet<Service> Services { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ReservationV2>()
                .HasOne(r => r.Service)
                .WithMany()
                .HasForeignKey(r => r.ServiceId);
        }

    }
}
