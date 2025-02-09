using SurisAPI.Models;
using System.Data;
using Microsoft.Data.SqlClient;
using SurisAPI.Services.Interfaces;
using SurisAPI.Models.Requests;
using Azure.Core;
using SurisAPI.Data;
using Microsoft.EntityFrameworkCore;
using SurisAPI.Models.Enums;

namespace SurisAPI.Services
{
    public class ReservationServiceV2 : IReservationServiceV2
    {
        private readonly SurisDBContext _context;
        public ReservationServiceV2(SurisDBContext context)
        {
            _context = context;
            context.Database.EnsureCreated();
        }

        public async Task<List<Reservation>> GetAll()
        {
            return await _context.Reservations.Include(r => r.Service).Select(r => new Reservation
            {
                Id = r.Id,
                Client = r.Client,
                DateTime = r.DateTime,
                Service = r.Service
            }).ToListAsync();
        }

        public async Task<List<Reservation>> GetByClient(string client)
        {
            return await _context.Reservations
                .Where(r => r.Client == client)
                .Include(r => r.Service)
                .Select(r => new Reservation
                {
                    Id = r.Id,
                    Client = r.Client,
                    DateTime = r.DateTime,
                    Service = r.Service
                }).ToListAsync();
        }

        public async Task<List<Service>> GetAllServices()
        {
            return await _context.Services.ToListAsync();
        }

        public async Task AddReservation(ReservationAddRequest request)
        {
            if (request.DateTime < DateTime.UtcNow)
            {
                throw new ArgumentException("La reserva no puede estar en el pasado.");
            }

            bool clientHasReservationForDay = await _context.Reservations
                .AnyAsync(r => r.Client == request.Client && r.DateTime.Date == request.DateTime.Date);

            if (clientHasReservationForDay)
            {
                throw new ArgumentException("El cliente ya tiene una reserva para este día.");
            }

            ReservationV2? existingReservation = await _context.Reservations
                                                .FirstOrDefaultAsync(r => r.DateTime == request.DateTime);

            if (existingReservation != null)
            {
                throw new ArgumentException("Ya existe una reserva para esta fecha.");
            }

            Service? service = await _context.Services
                                .FirstOrDefaultAsync(s => s.Id == request.ServiceId);

            if (service == null)
            {
                throw new ArgumentException("El servicio especificado no existe.");
            }

            ReservationV2 reservation = new ReservationV2
            {
                Client = request.Client,
                ServiceId = request.ServiceId,
                Service = service,
                DateTime = request.DateTime
            };

            _context.Reservations.Add(reservation);

            await _context.SaveChangesAsync();
        }

        public async Task<bool> DeleteReservation(int id)
        {
            ReservationV2? reservation = await _context.Reservations.FindAsync(id);

            if (reservation == null) {
                return false;
            };

            _context.Reservations.Remove(reservation);

            await _context.SaveChangesAsync();

            return true;
        }

    }
}
