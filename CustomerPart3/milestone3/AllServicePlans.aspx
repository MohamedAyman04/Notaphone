<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AllServicePlans.aspx.cs" Inherits="milestone3.AllServicePlans" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please Enter your phone number: 
            <asp:TextBox ID="TextMobileNo" runat="server" MaxLength="11" placeholder="Mobile Number"></asp:TextBox>
            <asp:Button ID="btnGetPlans" runat="server" Text="Get Plans" OnClick="GetPlansClick" />
        </div>
        <div>
            <asp:GridView ID="GridViewPlans" runat="server" AutoGenerateColumns="true"></asp:GridView>
        </div>
        <br/><br/>
        <asp:Button ID="Button1" runat="server" Text="Back" OnClick="BackClick" />
    </form>
</body>
</html>
