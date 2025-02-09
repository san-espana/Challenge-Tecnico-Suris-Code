using Microsoft.EntityFrameworkCore;
using SurisAPI.Data;
using SurisAPI.Services;
using SurisAPI.Services.Interfaces;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddSingleton<IConfiguration>(builder.Configuration);

builder.Services.AddDbContext<SurisDBContext>(options =>
{
    options.UseInMemoryDatabase("SurisDB");
});

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin", policy =>
    {
        policy.WithOrigins("http://localhost:5174", "https://localhost:7237")
              .WithMethods("GET", "POST")
              .AllowAnyHeader();
    });
});

builder.Services.AddSingleton<IReservationService, ReservationService>();
builder.Services.AddScoped<IReservationServiceV2, ReservationServiceV2>();
builder.Services.AddScoped<DatabaseSeeder>();

builder.Services.AddControllers();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

using (IServiceScope scope = app.Services.CreateScope())
{
    DatabaseSeeder seeder = scope.ServiceProvider.GetRequiredService<DatabaseSeeder>();
    seeder.SeedServices();
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors("AllowSpecificOrigin");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
