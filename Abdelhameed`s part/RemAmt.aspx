<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemAmt.aspx.cs" Inherits="Abdelhameed_s_part.RemAmt" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: #D4D9D5;">
    <form id="form1" runat="server">
        <div style="font-size: 20px; color: #007BFF">
            Please type your plan name :<br />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </div>
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Show amount" CssClass="custom-button" OnClick="Button1_Click" />
        <br />
        <br />
        <div style="font-size: 20px; color: #007BFF">
            Remaining amount : <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Back" CssClass="custom-button" OnClick="Button2_Click" />
        <br />
        <style>
            .custom-button {
                background-color: transparent;
                border: 2px solid #007bff;
                color: #007bff;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
            }
            .custom-button:hover {
                background-color: #007bff;
                color: white;
            }
        </style>
    </form>
</body>
</html>
