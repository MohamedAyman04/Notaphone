using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class AccountUsagePlanResult
	{
		private int _planId { get; set; }
		public int? PlanId
		{
			get => _planId;
			set => _planId = value ?? 0;
		}

		private int _totalData { get; set; }
		[Column("total data")]
		public int? TotalData
		{
			get => _totalData;
			set => _totalData = value ?? 0;
		}

		private int _totalMinutes { get; set; }
		[Column("total mins")]
		public int? TotalMinutes
		{
			get => _totalMinutes;
			set => _totalMinutes = value ?? 0;
		}

		private int _totalSMS { get; set; }
		[Column("total sms")]
		public int? TotalSMS
		{
			get => _totalSMS;
			set => _totalSMS = value ?? 0;
		}
		public override string? ToString()
		{
			return
				PlanId.ToString() + ", " +
				TotalData.ToString() + ", " +
				TotalMinutes.ToString() + ", " +
				TotalSMS.ToString() + ", ";
		}
	}
}
