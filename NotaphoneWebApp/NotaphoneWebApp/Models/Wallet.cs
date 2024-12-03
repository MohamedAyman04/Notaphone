using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Wallet
{
    public int WalletId { get; set; }

    public decimal? CurrentBalance { get; set; }

    public string? Currency { get; set; }

    public DateTime? LastModifiedDate { get; set; }

    public int? NationalId { get; set; }

    public string? MobileNo { get; set; }

    public virtual ICollection<Cashback> Cashbacks { get; set; } = new List<Cashback>();

    public virtual CustomerProfile? National { get; set; }

    public virtual ICollection<TransferMoney> TransferMoneyWalletId1Navigations { get; set; } = new List<TransferMoney>();

    public virtual ICollection<TransferMoney> TransferMoneyWalletId2Navigations { get; set; } = new List<TransferMoney>();
}
