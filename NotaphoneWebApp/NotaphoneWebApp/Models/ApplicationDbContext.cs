using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace NotaphoneWebApp.Models;

public partial class ApplicationDbContext : DbContext
{
    public ApplicationDbContext()
    {
    }

    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public virtual DbSet<AccountPayment> AccountPayments { get; set; }

    public virtual DbSet<AllBenefit> AllBenefits { get; set; }

    public virtual DbSet<AllCustomerAccount> AllCustomerAccounts { get; set; }

    public virtual DbSet<AllResolvedTicket> AllResolvedTickets { get; set; }

    public virtual DbSet<AllServicePlan> AllServicePlans { get; set; }

    public virtual DbSet<AllShop> AllShops { get; set; }

    public virtual DbSet<Benefit> Benefits { get; set; }

    public virtual DbSet<Cashback> Cashbacks { get; set; }

    public virtual DbSet<CustomerAccount> CustomerAccounts { get; set; }

    public virtual DbSet<CustomerProfile> CustomerProfiles { get; set; }

    public virtual DbSet<CustomerWallet> CustomerWallets { get; set; }

    public virtual DbSet<EShop> EShops { get; set; }

    public virtual DbSet<EShopVoucher> EShopVouchers { get; set; }

    public virtual DbSet<ExclusiveOffer> ExclusiveOffers { get; set; }

    public virtual DbSet<NumOfCashback> NumOfCashbacks { get; set; }

    public virtual DbSet<Payment> Payments { get; set; }

    public virtual DbSet<PhysicalShop> PhysicalShops { get; set; }

    public virtual DbSet<PhysicalStoreVoucher> PhysicalStoreVouchers { get; set; }

    public virtual DbSet<PlanUsage> PlanUsages { get; set; }

    public virtual DbSet<PointsGroup> PointsGroups { get; set; }

    public virtual DbSet<ProcessPayment> ProcessPayments { get; set; }

    public virtual DbSet<ServicePlan> ServicePlans { get; set; }

    public virtual DbSet<Shop> Shops { get; set; }

    public virtual DbSet<Subscription> Subscriptions { get; set; }

    public virtual DbSet<TechnicalSupportTicket> TechnicalSupportTickets { get; set; }

    public virtual DbSet<TransferMoney> TransferMoneys { get; set; }

    public virtual DbSet<Voucher> Vouchers { get; set; }

    public virtual DbSet<Wallet> Wallets { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        => optionsBuilder.UseSqlServer("Name=ConnectionStrings:defaultstring");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<AccountPayment>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("AccountPayments");

            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 1)")
                .HasColumnName("amount");
            entity.Property(e => e.DateOfPayment)
                .HasColumnType("date")
                .HasColumnName("date_of_payment");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.PaymentId)
                .ValueGeneratedOnAdd()
                .HasColumnName("paymentID");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("payment_method");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
        });

        modelBuilder.Entity<AllBenefit>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("allBenefits");

            entity.Property(e => e.BenefitId)
                .ValueGeneratedOnAdd()
                .HasColumnName("benefitID");
            entity.Property(e => e.Description)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
            entity.Property(e => e.ValidityDate)
                .HasColumnType("date")
                .HasColumnName("validity_date");
        });

        modelBuilder.Entity<AllCustomerAccount>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("allCustomerAccounts");

            entity.Property(e => e.AccountType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("account_type");
            entity.Property(e => e.Address)
                .HasMaxLength(70)
                .IsUnicode(false)
                .HasColumnName("address");
            entity.Property(e => e.Balance)
                .HasColumnType("decimal(10, 1)")
                .HasColumnName("balance");
            entity.Property(e => e.DateOfBirth)
                .HasColumnType("date")
                .HasColumnName("date_of_birth");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("first_name");
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("last_name");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.NationalId).HasColumnName("nationalID");
            entity.Property(e => e.Points).HasColumnName("points");
            entity.Property(e => e.StartDate)
                .HasColumnType("date")
                .HasColumnName("start_date");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
        });

        modelBuilder.Entity<AllResolvedTicket>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("allResolvedTickets");

            entity.Property(e => e.IssueDescription)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("issue_description");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.PriorityLevel).HasColumnName("priority_level");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
            entity.Property(e => e.TicketId)
                .ValueGeneratedOnAdd()
                .HasColumnName("ticketID");
        });

        modelBuilder.Entity<AllServicePlan>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("allServicePlans");

            entity.Property(e => e.DataOffered).HasColumnName("data_offered");
            entity.Property(e => e.Description)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.MinutesOffered).HasColumnName("minutes_offered");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.PlanId)
                .ValueGeneratedOnAdd()
                .HasColumnName("planID");
            entity.Property(e => e.Price).HasColumnName("price");
            entity.Property(e => e.SmsOffered).HasColumnName("SMS_offered");
        });

        modelBuilder.Entity<AllShop>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("allShops");

            entity.Property(e => e.Category)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.ShopId)
                .ValueGeneratedOnAdd()
                .HasColumnName("shopID");
        });

        modelBuilder.Entity<Benefit>(entity =>
        {
            entity.HasKey(e => e.BenefitId).HasName("PK__Benefits__50D7FCB4D881B162");

            entity.Property(e => e.BenefitId).HasColumnName("benefitID");
            entity.Property(e => e.Description)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
            entity.Property(e => e.ValidityDate)
                .HasColumnType("date")
                .HasColumnName("validity_date");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.Benefits)
                .HasForeignKey(d => d.MobileNo)
                .HasConstraintName("FK__Benefits__mobile__5DCAEF64");
        });

        modelBuilder.Entity<Cashback>(entity =>
        {
            entity.HasKey(e => new { e.CashbackId, e.BenefitId }).HasName("pk_Cashback");

            entity.ToTable("Cashback");

            entity.Property(e => e.CashbackId)
                .ValueGeneratedOnAdd()
                .HasColumnName("cashbackID");
            entity.Property(e => e.BenefitId).HasColumnName("benefitID");
            entity.Property(e => e.Amount).HasColumnName("amount");
            entity.Property(e => e.CreditDate)
                .HasColumnType("date")
                .HasColumnName("credit_date");
            entity.Property(e => e.WalletId).HasColumnName("walletID");

            entity.HasOne(d => d.Benefit).WithMany(p => p.Cashbacks)
                .HasForeignKey(d => d.BenefitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Cashback__benefi__6754599E");

            entity.HasOne(d => d.Wallet).WithMany(p => p.Cashbacks)
                .HasForeignKey(d => d.WalletId)
                .HasConstraintName("FK__Cashback__wallet__68487DD7");
        });

        modelBuilder.Entity<CustomerAccount>(entity =>
        {
            entity.HasKey(e => e.MobileNo).HasName("PK__customer__4D7970A9DB920D8E");

            entity.ToTable("customer_account");

            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.AccountType)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("account_type");
            entity.Property(e => e.Balance)
                .HasColumnType("decimal(10, 1)")
                .HasColumnName("balance");
            entity.Property(e => e.NationalId).HasColumnName("nationalID");
            entity.Property(e => e.Pass)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("pass");
            entity.Property(e => e.Points)
                .HasDefaultValueSql("((0))")
                .HasColumnName("points");
            entity.Property(e => e.StartDate)
                .HasColumnType("date")
                .HasColumnName("start_date");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.National).WithMany(p => p.CustomerAccounts)
                .HasForeignKey(d => d.NationalId)
                .HasConstraintName("FK__customer___natio__3E52440B");
        });

        modelBuilder.Entity<CustomerProfile>(entity =>
        {
            entity.HasKey(e => e.NationalId).HasName("PK__customer__B5881E89C704B378");

            entity.ToTable("customer_profile");

            entity.Property(e => e.NationalId)
                .ValueGeneratedNever()
                .HasColumnName("nationalID");
            entity.Property(e => e.Address)
                .HasMaxLength(70)
                .IsUnicode(false)
                .HasColumnName("address");
            entity.Property(e => e.DateOfBirth)
                .HasColumnType("date")
                .HasColumnName("date_of_birth");
            entity.Property(e => e.Email)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("email");
            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("first_name");
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("last_name");
        });

        modelBuilder.Entity<CustomerWallet>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("CustomerWallet");

            entity.Property(e => e.Currency)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("currency");
            entity.Property(e => e.CurrentBalance)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("current_balance");
            entity.Property(e => e.FirstName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("first_name");
            entity.Property(e => e.LastModifiedDate)
                .HasColumnType("date")
                .HasColumnName("last_modified_date");
            entity.Property(e => e.LastName)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("last_name");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.NationalId).HasColumnName("nationalID");
            entity.Property(e => e.WalletId).HasColumnName("walletID");
        });

        modelBuilder.Entity<EShop>(entity =>
        {
            entity.HasKey(e => e.ShopId).HasName("PK__E_shop__E5C424FC6566022C");

            entity.ToTable("E_shop");

            entity.Property(e => e.ShopId)
                .ValueGeneratedNever()
                .HasColumnName("shopID");
            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.Url)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("URL");

            entity.HasOne(d => d.Shop).WithOne(p => p.EShop)
                .HasForeignKey<EShop>(d => d.ShopId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__E_shop__shopID__73BA3083");
        });

        modelBuilder.Entity<EShopVoucher>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("E_shopVouchers");

            entity.Property(e => e.Rating).HasColumnName("rating");
            entity.Property(e => e.ShopId).HasColumnName("shopID");
            entity.Property(e => e.Url)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("URL");
            entity.Property(e => e.Value).HasColumnName("value");
            entity.Property(e => e.VoucherId).HasColumnName("voucherID");
        });

        modelBuilder.Entity<ExclusiveOffer>(entity =>
        {
            entity.HasKey(e => new { e.OfferId, e.BenefitId }).HasName("pk_Exclusive_offer");

            entity.ToTable("Exclusive_offer");

            entity.Property(e => e.OfferId)
                .ValueGeneratedOnAdd()
                .HasColumnName("offerID");
            entity.Property(e => e.BenefitId).HasColumnName("benefitID");
            entity.Property(e => e.InternetOffered).HasColumnName("internet_offered");
            entity.Property(e => e.MinutesOffered).HasColumnName("minutes_offered");
            entity.Property(e => e.SmsOffered).HasColumnName("SMS_offered");

            entity.HasOne(d => d.Benefit).WithMany(p => p.ExclusiveOffers)
                .HasForeignKey(d => d.BenefitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Exclusive__benef__6477ECF3");
        });

        modelBuilder.Entity<NumOfCashback>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("Num_of_cashback");

            entity.Property(e => e.CountOfTransactions).HasColumnName("count of transactions");
            entity.Property(e => e.WalletId).HasColumnName("walletID");
        });

        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("PK__Payment__A0D9EFA6D005C4B8");

            entity.ToTable("Payment");

            entity.Property(e => e.PaymentId).HasColumnName("paymentID");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 1)")
                .HasColumnName("amount");
            entity.Property(e => e.DateOfPayment)
                .HasColumnType("date")
                .HasColumnName("date_of_payment");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.PaymentMethod)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("payment_method");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.Payments)
                .HasForeignKey(d => d.MobileNo)
                .HasConstraintName("FK__Payment__mobileN__4D94879B");
        });

        modelBuilder.Entity<PhysicalShop>(entity =>
        {
            entity.HasKey(e => e.ShopId).HasName("PK__Physical__E5C424FC553CF64B");

            entity.ToTable("Physical_shop");

            entity.Property(e => e.ShopId)
                .ValueGeneratedNever()
                .HasColumnName("shopID");
            entity.Property(e => e.Address)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("address");
            entity.Property(e => e.WorkingHours)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("working_hours");

            entity.HasOne(d => d.Shop).WithOne(p => p.PhysicalShop)
                .HasForeignKey<PhysicalShop>(d => d.ShopId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Physical___shopI__70DDC3D8");
        });

        modelBuilder.Entity<PhysicalStoreVoucher>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("PhysicalStoreVouchers");

            entity.Property(e => e.Address)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("address");
            entity.Property(e => e.ShopId).HasColumnName("shopID");
            entity.Property(e => e.Value).HasColumnName("value");
            entity.Property(e => e.VoucherId).HasColumnName("voucherID");
            entity.Property(e => e.WorkingHours)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("working_hours");
        });

        modelBuilder.Entity<PlanUsage>(entity =>
        {
            entity.HasKey(e => e.UsageId).HasName("PK__Plan_Usa__638A2FB69C943123");

            entity.ToTable("Plan_Usage");

            entity.Property(e => e.UsageId).HasColumnName("usageID");
            entity.Property(e => e.DataConsumption).HasColumnName("data_consumption");
            entity.Property(e => e.EndDate)
                .HasColumnType("date")
                .HasColumnName("end_date");
            entity.Property(e => e.MinutesUsed).HasColumnName("minutes_used");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.PlanId).HasColumnName("planID");
            entity.Property(e => e.SmsSent).HasColumnName("SMS_sent");
            entity.Property(e => e.StartDate)
                .HasColumnType("date")
                .HasColumnName("start_date");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.PlanUsages)
                .HasForeignKey(d => d.MobileNo)
                .HasConstraintName("FK__Plan_Usag__mobil__47DBAE45");

            entity.HasOne(d => d.Plan).WithMany(p => p.PlanUsages)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__Plan_Usag__planI__48CFD27E");
        });

        modelBuilder.Entity<PointsGroup>(entity =>
        {
            entity.HasKey(e => new { e.PointId, e.BenefitId }).HasName("pk_Points_group");

            entity.ToTable("Points_group");

            entity.Property(e => e.PointId)
                .ValueGeneratedOnAdd()
                .HasColumnName("pointId");
            entity.Property(e => e.BenefitId).HasColumnName("benefitID");
            entity.Property(e => e.PaymentId).HasColumnName("paymentId");
            entity.Property(e => e.PointsAmount).HasColumnName("pointsAmount");

            entity.HasOne(d => d.Benefit).WithMany(p => p.PointsGroups)
                .HasForeignKey(d => d.BenefitId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Points_gr__benef__619B8048");

            entity.HasOne(d => d.Payment).WithMany(p => p.PointsGroups)
                .HasForeignKey(d => d.PaymentId)
                .HasConstraintName("FK__Points_gr__payme__60A75C0F");
        });

        modelBuilder.Entity<ProcessPayment>(entity =>
        {
            entity.HasKey(e => e.PaymentId).HasName("pk_process_payment");

            entity.ToTable("process_payment");

            entity.Property(e => e.PaymentId)
                .ValueGeneratedNever()
                .HasColumnName("paymentID");
            entity.Property(e => e.ExtraAmount)
                .HasComputedColumnSql("([dbo].[function_extra_amount]([paymentID],[planID]))", false)
                .HasColumnName("extra_amount");
            entity.Property(e => e.PlanId).HasColumnName("planID");
            entity.Property(e => e.RemainingAmount)
                .HasComputedColumnSql("([dbo].[function_remaining_amount]([paymentID],[planID]))", false)
                .HasColumnName("remaining_amount");

            entity.HasOne(d => d.Payment).WithOne(p => p.ProcessPayment)
                .HasForeignKey<ProcessPayment>(d => d.PaymentId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__process_p__payme__5070F446");

            entity.HasOne(d => d.Plan).WithMany(p => p.ProcessPayments)
                .HasForeignKey(d => d.PlanId)
                .HasConstraintName("FK__process_p__planI__5165187F");
        });

        modelBuilder.Entity<ServicePlan>(entity =>
        {
            entity.HasKey(e => e.PlanId).HasName("PK__Service___A2942D18279BA4A3");

            entity.ToTable("Service_plan");

            entity.Property(e => e.PlanId).HasColumnName("planID");
            entity.Property(e => e.DataOffered).HasColumnName("data_offered");
            entity.Property(e => e.Description)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("description");
            entity.Property(e => e.MinutesOffered).HasColumnName("minutes_offered");
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("name");
            entity.Property(e => e.Price).HasColumnName("price");
            entity.Property(e => e.SmsOffered).HasColumnName("SMS_offered");

            entity.HasMany(d => d.Benefits).WithMany(p => p.Plans)
                .UsingEntity<Dictionary<string, object>>(
                    "PlanProvidesBenefit",
                    r => r.HasOne<Benefit>().WithMany()
                        .HasForeignKey("Benefitid")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__plan_prov__benef__6B24EA82"),
                    l => l.HasOne<ServicePlan>().WithMany()
                        .HasForeignKey("PlanId")
                        .OnDelete(DeleteBehavior.ClientSetNull)
                        .HasConstraintName("FK__plan_prov__planI__6C190EBB"),
                    j =>
                    {
                        j.HasKey("PlanId", "Benefitid").HasName("pk_plan_provides_benefits");
                        j.ToTable("plan_provides_benefits");
                        j.IndexerProperty<int>("PlanId").HasColumnName("planID");
                        j.IndexerProperty<int>("Benefitid").HasColumnName("benefitid");
                    });
        });

        modelBuilder.Entity<Shop>(entity =>
        {
            entity.HasKey(e => e.ShopId).HasName("PK__shop__E5C424FCFD37C159");

            entity.ToTable("shop");

            entity.Property(e => e.ShopId).HasColumnName("shopID");
            entity.Property(e => e.Category)
                .HasMaxLength(50)
                .IsUnicode(false);
            entity.Property(e => e.Name)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("name");
        });

        modelBuilder.Entity<Subscription>(entity =>
        {
            entity.HasKey(e => new { e.MobileNo, e.PlanId }).HasName("pk_subscription");

            entity.ToTable("Subscription");

            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.PlanId).HasColumnName("planID");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");
            entity.Property(e => e.SubscriptionDate)
                .HasColumnType("date")
                .HasColumnName("subscription_date");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.Subscriptions)
                .HasForeignKey(d => d.MobileNo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Subscript__mobil__440B1D61");

            entity.HasOne(d => d.Plan).WithMany(p => p.Subscriptions)
                .HasForeignKey(d => d.PlanId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Subscript__planI__44FF419A");
        });

        modelBuilder.Entity<TechnicalSupportTicket>(entity =>
        {
            entity.HasKey(e => new { e.TicketId, e.MobileNo }).HasName("pk_Technical_support_ticket");

            entity.ToTable("Technical_support_ticket");

            entity.Property(e => e.TicketId)
                .ValueGeneratedOnAdd()
                .HasColumnName("ticketID");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.IssueDescription)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("issue_description");
            entity.Property(e => e.PriorityLevel).HasColumnName("priority_level");
            entity.Property(e => e.Status)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasColumnName("status");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.TechnicalSupportTickets)
                .HasForeignKey(d => d.MobileNo)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Technical__statu__7B5B524B");
        });

        modelBuilder.Entity<TransferMoney>(entity =>
        {
            entity.HasKey(e => new { e.WalletId1, e.WalletId2, e.TransferId }).HasName("pk_transfer_money");

            entity.ToTable("transfer_money");

            entity.Property(e => e.WalletId1).HasColumnName("walletID1");
            entity.Property(e => e.WalletId2).HasColumnName("walletID2");
            entity.Property(e => e.TransferId)
                .ValueGeneratedOnAdd()
                .HasColumnName("transfer_id");
            entity.Property(e => e.Amount)
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("amount");
            entity.Property(e => e.TransferDate)
                .HasColumnType("date")
                .HasColumnName("transfer_date");

            entity.HasOne(d => d.WalletId1Navigation).WithMany(p => p.TransferMoneyWalletId1Navigations)
                .HasForeignKey(d => d.WalletId1)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__transfer___walle__59063A47");

            entity.HasOne(d => d.WalletId2Navigation).WithMany(p => p.TransferMoneyWalletId2Navigations)
                .HasForeignKey(d => d.WalletId2)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__transfer___walle__59FA5E80");
        });

        modelBuilder.Entity<Voucher>(entity =>
        {
            entity.HasKey(e => e.VoucherId).HasName("PK__Voucher__F5338989FE0DF86A");

            entity.ToTable("Voucher");

            entity.Property(e => e.VoucherId).HasColumnName("voucherID");
            entity.Property(e => e.ExpiryDate)
                .HasColumnType("date")
                .HasColumnName("expiry_date");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.Points).HasColumnName("points");
            entity.Property(e => e.RedeemDate)
                .HasColumnType("date")
                .HasColumnName("redeem_date");
            entity.Property(e => e.Shopid).HasColumnName("shopid");
            entity.Property(e => e.Value).HasColumnName("value");

            entity.HasOne(d => d.MobileNoNavigation).WithMany(p => p.Vouchers)
                .HasForeignKey(d => d.MobileNo)
                .HasConstraintName("FK__Voucher__mobileN__778AC167");

            entity.HasOne(d => d.Shop).WithMany(p => p.Vouchers)
                .HasForeignKey(d => d.Shopid)
                .HasConstraintName("FK__Voucher__shopid__76969D2E");
        });

        modelBuilder.Entity<Wallet>(entity =>
        {
            entity.HasKey(e => e.WalletId).HasName("PK__Wallet__3785C89055978164");

            entity.ToTable("Wallet");

            entity.Property(e => e.WalletId).HasColumnName("walletID");
            entity.Property(e => e.Currency)
                .HasMaxLength(50)
                .IsUnicode(false)
                .HasDefaultValueSql("('egp')")
                .HasColumnName("currency");
            entity.Property(e => e.CurrentBalance)
                .HasDefaultValueSql("((0))")
                .HasColumnType("decimal(10, 2)")
                .HasColumnName("current_balance");
            entity.Property(e => e.LastModifiedDate)
                .HasColumnType("date")
                .HasColumnName("last_modified_date");
            entity.Property(e => e.MobileNo)
                .HasMaxLength(11)
                .IsUnicode(false)
                .IsFixedLength()
                .HasColumnName("mobileNo");
            entity.Property(e => e.NationalId).HasColumnName("nationalID");

            entity.HasOne(d => d.National).WithMany(p => p.Wallets)
                .HasForeignKey(d => d.NationalId)
                .HasConstraintName("FK__Wallet__national__5629CD9C");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
