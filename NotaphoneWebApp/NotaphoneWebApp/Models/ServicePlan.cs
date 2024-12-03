using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class ServicePlan
{
    public int PlanId { get; set; }

    public string Name { get; set; } = null!;

    public int Price { get; set; }

    public int SmsOffered { get; set; }

    public int MinutesOffered { get; set; }

    public int DataOffered { get; set; }

    public string? Description { get; set; }

    public virtual ICollection<PlanUsage> PlanUsages { get; set; } = new List<PlanUsage>();

    public virtual ICollection<ProcessPayment> ProcessPayments { get; set; } = new List<ProcessPayment>();

    public virtual ICollection<Subscription> Subscriptions { get; set; } = new List<Subscription>();

    public virtual ICollection<Benefit> Benefits { get; set; } = new List<Benefit>();
}
