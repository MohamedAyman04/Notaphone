using System.Security.Claims;
using Microsoft.AspNetCore.Components.Authorization;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;

namespace NotaphoneWebApp
{

	public class CustomAuthStateProvider : AuthenticationStateProvider
	{
		private readonly ProtectedSessionStorage _sessionStorage;
		private ClaimsPrincipal _anonymous = new ClaimsPrincipal(new ClaimsIdentity());

		public CustomAuthStateProvider(ProtectedSessionStorage sessionStorage)
		{
			_sessionStorage = sessionStorage;
		}

		public override async Task<AuthenticationState> GetAuthenticationStateAsync()
		{
			Console.WriteLine("Getting");
			try
			{
				//await Task.Delay(5000);
				var userSessionStorageResult = await _sessionStorage.GetAsync<UserSession>("UserSession");
				var userSession = userSessionStorageResult.Success ? userSessionStorageResult.Value : null;

				if (userSession == null)
				return await Task.FromResult(new AuthenticationState(_anonymous));

				var claimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>
				{
					new Claim(ClaimTypes.MobilePhone, userSession.MobilePhone),
					new Claim(ClaimTypes.Role, userSession.Role)
				}, "CustomAuth"));

				Console.WriteLine("Printing");
				Console.WriteLine(userSession.MobilePhone);
				Console.WriteLine(userSession.Role);

				return await Task.FromResult(new AuthenticationState(claimsPrincipal));
			}
			catch (Exception ex)
			{
				Console.WriteLine($"{ex.Message}");
				return await Task.FromResult(new AuthenticationState(_anonymous));
			}
		}

		public async Task UpdateAuthenticationState(UserSession userSession)
		{
			Console.WriteLine("Updating");
			ClaimsPrincipal claimsPrincipal;

			if (userSession != null)
			{
				await _sessionStorage.SetAsync("UserSession", userSession);
				claimsPrincipal = new ClaimsPrincipal(new ClaimsIdentity(new List<Claim>
				{
					new Claim(ClaimTypes.MobilePhone, userSession.MobilePhone),
					new Claim(ClaimTypes.Role, userSession.Role)
				}));
				Console.WriteLine(userSession.MobilePhone);
				Console.WriteLine(userSession.Role);
			}
			else
			{
				await _sessionStorage.DeleteAsync("UserSession");
				claimsPrincipal = _anonymous;
			}

			NotifyAuthenticationStateChanged(Task.FromResult(new AuthenticationState(claimsPrincipal)));
		}
	}
}
