using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Subscription
{
    public string MobileNo { get; set; } = null!;

    public int PlanId { get; set; }

    public DateTime? SubscriptionDate { get; set; }

    public string? Status { get; set; }

    public virtual CustomerAccount MobileNoNavigation { get; set; } = null!;

    public virtual ServicePlan Plan { get; set; } = null!;
}
