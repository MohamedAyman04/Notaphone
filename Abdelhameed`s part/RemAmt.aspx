﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemAmt.aspx.cs" Inherits="Abdelhameed_s_part.RemAmt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please type your plan name :<br />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <br />
        </div>
        <asp:Button ID="Button1" runat="server" Text="Show amount" OnClick="Button1_Click" />
        <br />
        <br />
        Remaining amount :
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Back" OnClick="Button2_Click" />
        <br />
    </form>
</body>
</html>
