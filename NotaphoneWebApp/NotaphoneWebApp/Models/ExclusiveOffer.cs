using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class ExclusiveOffer
{
    public int OfferId { get; set; }

    public int BenefitId { get; set; }

    public int? InternetOffered { get; set; }

    public int? SmsOffered { get; set; }

    public int? MinutesOffered { get; set; }

    public virtual Benefit Benefit { get; set; } = null!;
}
