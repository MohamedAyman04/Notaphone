namespace NotaphoneWebApp.Models
{
    public class AccountPaymentPointsResult
    {
        private int _numberOfPaymentID;
        public int? NumberOfPaymentID {
            get => _numberOfPaymentID;
            set => _numberOfPaymentID = value ?? 0;
        }

        private int _totalPoints;
        public int? TotalPoints
        {
            get => _totalPoints;
            set => _totalPoints = value ?? 0;
        }

    }
}
