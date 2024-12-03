using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class PhysicalStoreVoucher
{
    public int ShopId { get; set; }

    public string? Address { get; set; }

    public string? WorkingHours { get; set; }

    public int VoucherId { get; set; }

    public int? Value { get; set; }
}
