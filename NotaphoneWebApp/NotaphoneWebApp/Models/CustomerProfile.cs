using System;
using System.Collections.Generic;

namespace NotaphoneWebApp.Models;

public partial class CustomerProfile
{
    public int NationalId { get; set; }

    public string FirstName { get; set; } = null!;

    public string LastName { get; set; } = null!;

    public string? Email { get; set; }

    public string Address { get; set; } = null!;

    public DateTime? DateOfBirth { get; set; }

    public virtual ICollection<CustomerAccount> CustomerAccounts { get; set; } = new List<CustomerAccount>();

    public virtual ICollection<Wallet> Wallets { get; set; } = new List<Wallet>();
}
