using SurisAPI.Models.Enums;
using SurisAPI.Models;
using System.Text.RegularExpressions;

namespace SurisAPI.Data
{
    public class DatabaseSeeder
    {
        private readonly SurisDBContext _context;

        public DatabaseSeeder(SurisDBContext context)
        {
            _context = context;
        }

        public void SeedServices()
        {
            if (!_context.Services.Any())
            {
                foreach (ServiceTypes serviceType in Enum.GetValues(typeof(ServiceTypes)))
                {
                    string serviceName = serviceType.ToString() ?? "Unknown Service";
                    serviceName = Regex.Replace(serviceName, @"([a-z])([A-Z])", "$1 $2");

                    _context.Services.Add(new Service
                    {
                        Id = (int)serviceType,
                        Name = serviceName
                    });
                }

                _context.SaveChanges();
            }
        }
    }
}
