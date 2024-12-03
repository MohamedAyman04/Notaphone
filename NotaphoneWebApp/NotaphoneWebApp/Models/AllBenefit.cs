using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class AllBenefit
{
    public int BenefitId { get; set; }

    public string? Description { get; set; }

    public DateTime? ValidityDate { get; set; }

    public string? Status { get; set; }

    public string? MobileNo { get; set; }
}
