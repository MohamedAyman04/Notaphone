using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Payment
{
    public int PaymentId { get; set; }

    public decimal Amount { get; set; }

    public DateTime DateOfPayment { get; set; }

    public string? PaymentMethod { get; set; }

    public string? Status { get; set; }

    public string? MobileNo { get; set; }

    public virtual CustomerAccount? MobileNoNavigation { get; set; }

    public virtual ICollection<PointsGroup> PointsGroups { get; set; } = new List<PointsGroup>();

    public virtual ProcessPayment? ProcessPayment { get; set; }
}
