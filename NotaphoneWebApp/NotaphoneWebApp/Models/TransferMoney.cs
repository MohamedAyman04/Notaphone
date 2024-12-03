using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class TransferMoney
{
    public int WalletId1 { get; set; }

    public int WalletId2 { get; set; }

    public int TransferId { get; set; }

    public decimal? Amount { get; set; }

    public DateTime? TransferDate { get; set; }

    public virtual Wallet WalletId1Navigation { get; set; } = null!;

    public virtual Wallet WalletId2Navigation { get; set; } = null!;
}
