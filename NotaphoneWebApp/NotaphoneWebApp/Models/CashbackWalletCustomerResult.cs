using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
	public class CashbackWalletCustomerResult
	{

		private int _cashbackId { get; set; }
		public int? CashbackId
		{
			get => _cashbackId;
			set => _cashbackId = value ?? 0;
		}

		private int _benefitId { get; set; }
		public int? BenefitId
		{
			get => _benefitId;
			set => _benefitId = value ?? 0;
		}

		private int _walletId { get; set; }
		public int? WalletId
		{
			get => _walletId;
			set => _walletId = value ?? 0;
		}

		private int _amount { get; set; }
		public int? Amount
		{
			get => _amount;
			set => _amount = value ?? 0;
		}

		[Column("credit_date")]
		public DateTime? CreditDate { get; set; }

		public override string? ToString()
		{
			return
				_cashbackId.ToString() + ", " +
				_benefitId.ToString() + ", " +
				_walletId.ToString() + ", " +
				_amount.ToString() + ", " +
				CreditDate;
		}

	}
}
