<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer1.aspx.cs" Inherits="Ahmed_part.Customer1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
        <asp:Button ID="btnServicePlans" runat="server" OnClick="ServicePlansClick" Text="View Offered Service Plans" />
            <br />
        </div>
        <p>
            <asp:Button ID="btnTotalComsumption" runat="server" OnClick="TotalConsumptionClick" Text="View Total Consumption" />
        </p>
        <asp:Button ID="btnOfferedPlans" runat="server" OnClick="OfferedPlansClick" Text="Display Offered Plans" />
        <br />
        <br />
        <asp:Button ID="btnPlanUsage" runat="server" OnClick="PlanUsageClick" Text="Show Plan Usage" />
        <p>
            <asp:Button ID="btnCashbackTransactions" runat="server" OnClick="CashbackTransactionsClick" Text="Show Cashback Transactions" />
        </p>
    </form>
</body>
</html>
