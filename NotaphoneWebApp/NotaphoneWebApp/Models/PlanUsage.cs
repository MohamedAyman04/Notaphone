using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class PlanUsage
{
    public int UsageId { get; set; }

    public DateTime StartDate { get; set; }

    public DateTime EndDate { get; set; }

    public int? DataConsumption { get; set; }

    public int? MinutesUsed { get; set; }

    public int? SmsSent { get; set; }

    public string? MobileNo { get; set; }

    public int? PlanId { get; set; }

    public virtual CustomerAccount? MobileNoNavigation { get; set; }

    public virtual ServicePlan? Plan { get; set; }
}
