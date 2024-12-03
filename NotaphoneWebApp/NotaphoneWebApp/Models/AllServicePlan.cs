using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class AllServicePlan
{
    public int PlanId { get; set; }

    public string Name { get; set; } = null!;

    public int Price { get; set; }

    public int SmsOffered { get; set; }

    public int MinutesOffered { get; set; }

    public int DataOffered { get; set; }

    public string? Description { get; set; }
}
