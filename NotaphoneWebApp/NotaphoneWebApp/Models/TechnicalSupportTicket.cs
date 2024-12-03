using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class TechnicalSupportTicket
{
    public int TicketId { get; set; }

    public string MobileNo { get; set; } = null!;

    public string? IssueDescription { get; set; }

    public int? PriorityLevel { get; set; }

    public string? Status { get; set; }

    public virtual CustomerAccount MobileNoNavigation { get; set; } = null!;
}
