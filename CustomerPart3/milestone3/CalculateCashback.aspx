<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CalculateCashback.aspx.cs" Inherits="milestone3.CalculateCashback" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Enter your phone number: 
            <asp:TextBox ID="TextMobileNo" runat="server" placeholder="Mobile Number"></asp:TextBox>
            <br/>
            Enter your payment ID: 
            <asp:TextBox ID="TextPaymentID" runat="server" placeholder="Payment ID"></asp:TextBox>
            <br/>
            Enter your benefit ID: 
            <asp:TextBox ID="TextBenefitID" runat="server" placeholder="Benefit ID"></asp:TextBox>
            <br/><br/>
            <asp:Button ID="btnCalculate" runat="server" Text="Calculate Cashback" OnClick="CalculateCashbackClick" />
            <br/><br/>
            <asp:Label ID="LabelResult" runat="server" Text="" ForeColor="Green"></asp:Label>
            <br/><br/>
            <asp:Button ID="Button1" runat="server" Text="Back" OnClick="BackClick" />
        </div>
    </form>
</body>
</html>
