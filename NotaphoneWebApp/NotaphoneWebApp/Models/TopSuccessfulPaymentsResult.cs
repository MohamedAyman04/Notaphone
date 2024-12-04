using System.ComponentModel.DataAnnotations.Schema;

namespace NotaphoneWebApp.Models
{
    public class TopSuccessfulPaymentsResult
    {

        private int _paymentId;
        public int? PaymentId
        {
            get => _paymentId;
            set => _paymentId = value ?? 0;
        }

        private decimal _amount;
        public decimal? Amount
        {
            get => _amount;
            set => _amount = value ?? 0;
        }

        [Column("date_of_payment")]
        public DateTime DateOfPayment;

        private string _paymentMethod;
        [Column("payment_method")]
        public string? PaymentMethod
        {
            get => _paymentMethod;
            set => _paymentMethod = value ?? "";
        }

        private string _status;
        public string? Status
        {
            get => _status;
            set => _status = value ?? "";
        }

        private string? _mobileNo;
        public string? MobileNo
        {
            get => _mobileNo;
            set => _mobileNo = value ?? "";
        }

		public override string ToString()
		{
			return
				PaymentId.ToString() + ", " +
				Amount.ToString() + ", " +
				DateOfPayment.ToString() + ", " +
				PaymentMethod.ToString() + ", " +
				Status.ToString() + ", " +
				MobileNo.ToString() + ", ";
		}
	}
}
