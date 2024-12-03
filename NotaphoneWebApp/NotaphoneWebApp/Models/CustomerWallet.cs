using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class CustomerWallet
{
    public int WalletId { get; set; }

    public decimal? CurrentBalance { get; set; }

    public string? Currency { get; set; }

    public DateTime? LastModifiedDate { get; set; }

    public int? NationalId { get; set; }

    public string? MobileNo { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;
}
