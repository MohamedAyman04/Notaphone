using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class EShop
{
    public int ShopId { get; set; }

    public string Url { get; set; } = null!;

    public int? Rating { get; set; }

    public virtual Shop Shop { get; set; } = null!;
}
