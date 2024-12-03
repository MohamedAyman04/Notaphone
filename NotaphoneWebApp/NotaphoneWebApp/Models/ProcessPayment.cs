using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class ProcessPayment
{
    public int PaymentId { get; set; }

    public int? PlanId { get; set; }

    public int? RemainingAmount { get; set; }

    public int? ExtraAmount { get; set; }

    public virtual Payment Payment { get; set; } = null!;

    public virtual ServicePlan? Plan { get; set; }
}
