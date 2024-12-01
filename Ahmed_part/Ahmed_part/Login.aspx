<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Ahmed_part.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
         
        <p>
            Please Login</p>
        <p>
            &nbsp;</p>
        <p>
            Mobile Number:</p>
        <p>
            <asp:TextBox ID="mobilenumber" runat="server"></asp:TextBox>
        </p>
        <p>
            Password :</p>
        <p>
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
        </p>
        <p>
            &nbsp;</p>
        <p>
        
         
        <asp:Button ID="btnLogin" runat="server" OnClick="LoginClick" Text="Log In" Width="74px" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
