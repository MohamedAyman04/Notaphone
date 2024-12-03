using Microsoft.EntityFrameworkCore;
using NotaphoneWebApp.Components;
using NotaphoneWebApp.Models;

var builder = WebApplication.CreateBuilder(args);

var connectionString =
	builder.Configuration.GetConnectionString("defaultstring");

builder.Services.AddDbContextFactory<ApplicationDbContext>(options => 
	options.UseSqlServer());

// Add services to the container.
builder.Services.AddRazorComponents()
	.AddInteractiveServerComponents();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
	app.UseExceptionHandler("/Error", createScopeForErrors: true);
}

app.UseStaticFiles();
app.UseAntiforgery();

app.MapRazorComponents<App>()
	.AddInteractiveServerRenderMode();

app.Run();
