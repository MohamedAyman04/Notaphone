<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerPart3.aspx.cs" Inherits="milestone3.ShopDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button ID="Button1" runat="server" Text="View All Shops" OnClick="ShopClick"/>
            <br /><br/>
            <asp:Button ID="Button2" runat="server" Text="Show All Service Plans" OnClick="PlansClick"/>
            <br /><br/>
            <asp:Button ID="Button3" runat="server" Text="Renew Subscription" OnClick="RenewSubscriptionClick"/>
            <br /><br/>
            <asp:Button ID="Button4" runat="server" Text="Calculate Cashback" OnClick="CalculateCashbackClick"/>
            <br /><br/>
            <asp:Button ID="Button5" runat="server" Text="Recharge Balance" OnClick="RechargeBalance"/>
            <br /><br/>
            <asp:Button ID="Button6" runat="server" Text="Redeem Voucher" OnClick="RedeemVoucherClick"/>
        </div>
       
    </form>
</body>
</html>
