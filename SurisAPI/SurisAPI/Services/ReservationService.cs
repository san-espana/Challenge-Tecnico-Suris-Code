using SurisAPI.Models;
using System.Data;
using Microsoft.Data.SqlClient;
using SurisAPI.Services.Interfaces;
using SurisAPI.Models.Requests;
using Azure.Core;

namespace SurisAPI.Services
{
    public class ReservationService : IReservationService
    {
        private readonly string? _connectionString;
        public ReservationService(IConfiguration configuration)
        {
            _connectionString = configuration.GetConnectionString("DefaultConnection");

            if (string.IsNullOrEmpty(_connectionString))
            {
                throw new ArgumentNullException("Error en el Connection String");
            }

        }

        public List<Reservation> GetAll()
        {
            List<Reservation> reservations = new List<Reservation>();
            string procName = "[dbo].[Reservations_GetAll]";

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(procName, conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Reservation reservation = MapReservation(reader);
                        reservations.Add(reservation);
                    }
                }
            }

            return reservations;
        }

        public List<Reservation> GetByClient(string client)
        {
            List<Reservation> reservations = new List<Reservation>();
            string procName = "[dbo].[Reservations_GetByClient]";

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(procName, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Client", client);

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Reservation reservation = MapReservation(reader);
                        reservations.Add(reservation);
                    }
                }
            }

            return reservations;
        }

        private static Reservation MapReservation(SqlDataReader reader)
        {
            Reservation reservation = new Reservation
            {
                Id = reader.GetInt32("Id"),
                Client = reader.GetString("Client"),
                DateTime = reader.GetDateTime("Date"),
                Service = new Service
                {
                    Id = reader.GetInt32("ServiceId"),
                    Name = reader.GetString("ServiceName")
                }
            };

            return reservation;
        }

        public List<Service> GetAllServices()
        {
            List<Service> services = new List<Service>();
            string procName = "[dbo].[Services_GetAll]";

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(procName, conn);
                cmd.CommandType = CommandType.StoredProcedure;

                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Service service = new Service();
                        service.Id = reader.GetInt32("Id");
                        service.Name = reader.GetString("Name");
                        services.Add(service);
                    }
                }
            }

            return services;
        }
        public void AddReservation(ReservationAddRequest request)
        {
            string procName = "[dbo].[Reservations_Create]";

            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(procName, conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Client", request.Client);
                cmd.Parameters.AddWithValue("@ServiceId", request.ServiceId);
                cmd.Parameters.AddWithValue("@Date", request.DateTime);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

    }

}
