using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class ConsumptionResult
	{
		private int _dataConsumption { get; set; }
		[Column("data_consumption")]
		public int? DataConsumption
		{
			get => _dataConsumption;
			set => _dataConsumption = value ?? 0;
		}

		private int _minutesUsed { get; set; }
		[Column("minutes_used")]
		public int? MinutesUsed
		{
			get => _minutesUsed;
			set => _minutesUsed = value ?? 0;
		}

		private int _smsSent { get; set; }
		[Column("sms_sent")]
		public int? SMSSent
		{
			get => _smsSent;
			set => _smsSent = value ?? 0;
		}

		public override string? ToString()
		{
			return
				DataConsumption.ToString() + ", " +
				MinutesUsed.ToString() + ", " +
				SMSSent.ToString() + ", ";
		}

	}
}
