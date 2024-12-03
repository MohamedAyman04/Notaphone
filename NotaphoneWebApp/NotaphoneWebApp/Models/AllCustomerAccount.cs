using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class AllCustomerAccount
{
    public int NationalId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string? Email { get; set; }

    public string Address { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public string MobileNo { get; set; } = null!;

    public string? AccountType { get; set; }

    public string? Status { get; set; }

    public DateTime StartDate { get; set; }

    public decimal? Balance { get; set; }

    public int? Points { get; set; }
}
