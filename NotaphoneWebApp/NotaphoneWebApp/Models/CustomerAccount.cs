using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class CustomerAccount
{
    public string MobileNo { get; set; } = null!;

    public string? Pass { get; set; }

    public decimal? Balance { get; set; }

    public string? AccountType { get; set; }

    public DateTime StartDate { get; set; }

    public string? Status { get; set; }

    public int? Points { get; set; }

    public int? NationalId { get; set; }

    public virtual ICollection<Benefit> Benefits { get; set; } = new List<Benefit>();

    public virtual CustomerProfile? National { get; set; }

    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();

    public virtual ICollection<PlanUsage> PlanUsages { get; set; } = new List<PlanUsage>();

    public virtual ICollection<Subscription> Subscriptions { get; set; } = new List<Subscription>();

    public virtual ICollection<TechnicalSupportTicket> TechnicalSupportTickets { get; set; } = new List<TechnicalSupportTicket>();

    public virtual ICollection<Voucher> Vouchers { get; set; } = new List<Voucher>();
}
