using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class AccountPlanResult
	{
		private string _mobileNo;
		public string? MobileNo
		{
			get => _mobileNo;
			set => _mobileNo = value ?? "";
		}

		private string _pass { get; set; }
		public string? Pass
		{
			get => _pass;
			set => _pass = value ?? "";
		}

		private decimal _balance { get; set; }
		public decimal? Balance
		{
			get => _balance;
			set => _balance = value ?? 0;
		}

		private string _accountType { get; set; }
		[Column("account_type")]
		public string? AccountType
		{
			get => _accountType;
			set => _accountType = value ?? "";
		}

		[Column("start_date")]
		public DateTime? StartDate { get; set; }

		private string _status { get; set; }
		public string? Status
		{
			get => _status;
			set => _status = value ?? "";
		}

		private int _points { get; set; }
		public int? Points
		{
			get => _points;
			set => _points = value ?? 0;
		}

		private int _nationalId { get; set; }
		public int? NationalId
		{
			get => _nationalId;
			set => _nationalId = value ?? 0;
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

		private int _price { get; set; }
		public int? Price
		{
			get => _price;
			set => _price = value ?? 0;
		}

		private int _smsOffered { get; set; }
		[Column("sms_offered")]
		public int? SMSOffered
		{
			get => _smsOffered;
			set => _smsOffered = value ?? 0;
		}

		private int _minutesOffered { get; set; }
		[Column("minutes_offered")]
		public int? MinutesOffered
		{
			get => _minutesOffered;
			set => _minutesOffered = value ?? 0;
		}

		private int _dataOffered { get; set; }
		[Column("data_offered")]
		public int? DataOffered
		{
			get => _dataOffered;
			set => _dataOffered = value ?? 0;
		}

		private string _description { get; set; }
		public string? Description
		{
			get => _description;
			set => _description = value ?? "";
		}

		public override string? ToString()
		{
			return
				MobileNo.ToString() + ", " +
				Pass.ToString() + ", " +
				Balance.ToString() + ", " +
				AccountType.ToString() + ", " +
				StartDate.ToString() + ", " +
				Status.ToString() + ", " +
				Points.ToString() + ", " +
				NationalId.ToString() + ", " +
				PlanId.ToString() + ", " +
				Name.ToString() + ", " +
				Price.ToString() + ", " +
				SMSOffered.ToString() + ", " +
				MinutesOffered.ToString() + ", " +
				DataOffered.ToString() + ", " +
				Description.ToString();
		}
	}
}
