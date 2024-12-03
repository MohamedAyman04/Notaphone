using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class Benefit
{
    public int BenefitId { get; set; }

    public string? Description { get; set; }

    public DateTime? ValidityDate { get; set; }

    public string? Status { get; set; }

    public string? MobileNo { get; set; }

    public virtual ICollection<Cashback> Cashbacks { get; set; } = new List<Cashback>();

    public virtual ICollection<ExclusiveOffer> ExclusiveOffers { get; set; } = new List<ExclusiveOffer>();

    public virtual CustomerAccount? MobileNoNavigation { get; set; }

    public virtual ICollection<PointsGroup> PointsGroups { get; set; } = new List<PointsGroup>();

    public virtual ICollection<ServicePlan> Plans { get; set; } = new List<ServicePlan>();
}
