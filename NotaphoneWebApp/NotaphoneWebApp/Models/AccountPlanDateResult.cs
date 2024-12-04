namespace NotaphoneWebApp.Models
{
	public class AccountPlanDateResult
	{
		private string _mobileNo;
		public string? MobileNo
		{
			get => _mobileNo;
			set => _mobileNo = value ?? "";
		}
		private int _planId { get; set; }
		public int? PlanId
		{
			get => _planId;
			set => _planId = value ?? 0;
		}
		private string _name { get; set; } = null!;
		public string? Name
		{
			get => _name;
			set => _name = value ?? "";
		}

		public override string? ToString()
		{
			return
				MobileNo.ToString() + ", " +
				PlanId.ToString() + ", " +
				Name.ToString() + ", ";
		}
	}
}
