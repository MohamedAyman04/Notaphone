using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Cashback
{
    public int CashbackId { get; set; }

    public int BenefitId { get; set; }

    public int? WalletId { get; set; }

    public int? Amount { get; set; }

    public DateTime? CreditDate { get; set; }

    public virtual Benefit Benefit { get; set; } = null!;

    public virtual Wallet? Wallet { get; set; }
}
