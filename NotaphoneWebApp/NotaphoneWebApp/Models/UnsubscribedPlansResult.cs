using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class UnsubscribedPlansResult
	{
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
