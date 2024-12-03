<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RenewSubscription.aspx.cs" Inherits="milestone3.RenewSubscription" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter your Plan ID: 
            <asp:TextBox ID="TextPlanID" runat="server" placeholder="Plan ID"></asp:TextBox>
            <br/>
            Enter your phone number: 
            <asp:TextBox ID="TextMobileNo" runat="server" MaxLength="11" placeholder="Mobile Number"></asp:TextBox>
            <br/>
            Enter the Payment Method: 
            <asp:TextBox ID="TextPaymentMethod" runat="server" placeholder="Payment Method"></asp:TextBox>
            <br/>
            Enter the Amount: 
            <asp:TextBox ID="TextAmount" runat="server" placeholder="Amount"></asp:TextBox>
            <br/><br/>
            <asp:Button ID="btnRenew" runat="server" Text="Renew Subscription" OnClick="RenewSubscriptionClick" />        
            <br/><br/>
            <asp:Button ID="Button1" runat="server" Text="Back" OnClick="BackClick" />      
        </div>
    </form>
</body>
</html>
