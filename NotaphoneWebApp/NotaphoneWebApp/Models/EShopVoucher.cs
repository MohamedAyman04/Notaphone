using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class EShopVoucher
{
    public int ShopId { get; set; }

    public string Url { get; set; } = null!;

    public int? Rating { get; set; }

    public int VoucherId { get; set; }

    public int? Value { get; set; }
}
