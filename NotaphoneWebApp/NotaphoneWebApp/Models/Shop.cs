using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Shop
{
    public int ShopId { get; set; }

    public string? Name { get; set; }

    public string? Category { get; set; }

    public virtual EShop? EShop { get; set; }

    public virtual PhysicalShop? PhysicalShop { get; set; }

    public virtual ICollection<Voucher> Vouchers { get; set; } = new List<Voucher>();
}
