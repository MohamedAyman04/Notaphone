<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer2.aspx.cs" Inherits="Abdelhameed_s_part.Customer2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Button ID="allBenefits" runat="server" OnClick="ActiveBenefitsView" Text="Active Benefits" />
        <p>
            <asp:Button ID="NotResTickets" runat="server" OnClick="TicketAccountCustomerProc" Text="Not Resolved Tickets" />
        </p>
        <asp:Button ID="Button1" runat="server" Text="Highest Voucher" OnClick="Button1_Click" />
        <p>
            <asp:Button ID="Button2" runat="server" Text="Remaining amount" OnClick="Button2_Click" />
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" Text="Extra amount" OnClick="Button3_Click" />
        </p>
        <p>
            <asp:Button ID="Button4" runat="server" Text="Top Successful Payments" OnClick="Button4_Click" />
        </p>
    </form>
</body>
</html>
