using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class AccountSMSOffersResult
	{
		private int _offerId { get; set; }
		public int? OfferId
		{
			get => _offerId;
			set => _offerId = value ?? 0;
		}

		private int _benefitId { get; set; }
		public int? BenefitId
		{
			get => _benefitId;
			set => _benefitId = value ?? 0;
		}

		private int _internetOffered { get; set; }
		[Column("internet_offered")]
		public int? InternetOffered
		{
			get => _internetOffered;
			set => _internetOffered = value ?? 0;
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

		public override string? ToString()
		{
			return
				OfferId.ToString() + ", " +
				BenefitId.ToString() + ", " +
				InternetOffered.ToString() + ", " +
				SMSOffered.ToString() + ", " +
				MinutesOffered.ToString() + ", ";
		}
	}
}
