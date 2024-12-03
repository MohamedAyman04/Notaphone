using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class PhysicalShop
{
    public int ShopId { get; set; }

    public string? Address { get; set; }

    public string? WorkingHours { get; set; }

    public virtual Shop Shop { get; set; } = null!;
}
