using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Voucher
{
    public int VoucherId { get; set; }

    public int? Value { get; set; }

    public DateTime? ExpiryDate { get; set; }

    public int? Points { get; set; }

    public string? MobileNo { get; set; }

    public DateTime? RedeemDate { get; set; }

    public int? Shopid { get; set; }

    public virtual CustomerAccount? MobileNoNavigation { get; set; }

    public virtual Shop? Shop { get; set; }
}
