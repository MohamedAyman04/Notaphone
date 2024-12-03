using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class PointsGroup
{
    public int PointId { get; set; }

    public int BenefitId { get; set; }

    public int? PointsAmount { get; set; }

    public int? PaymentId { get; set; }

    public virtual Benefit Benefit { get; set; } = null!;

    public virtual Payment? Payment { get; set; }
}
