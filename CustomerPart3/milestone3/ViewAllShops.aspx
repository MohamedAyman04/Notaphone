<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewAllShops.aspx.cs" Inherits="milestone3.ViewAllShops" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server">
            </asp:GridView>
        </div>
        <br/>
        <br/>
        <asp:Button ID="Button1" runat="server" Text="Back" OnClick="BackClick" />
    </form>
</body>
</html>
