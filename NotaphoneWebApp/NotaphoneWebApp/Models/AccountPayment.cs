using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class AccountPayment
{
    public int PaymentId { get; set; }

    public decimal Amount { get; set; }

    public DateTime DateOfPayment { get; set; }

    public string? PaymentMethod { get; set; }

    public string? Status { get; set; }

    public string? MobileNo { get; set; }
}
