<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NRT.aspx.cs" Inherits="Abdelhameed_s_part.NRT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: #D4D9D5;">
    <form id="form1" runat="server">
        <div style="font-size: 20px; color: #007BFF">
            Please type your National ID :<br />
        </div>
        <div style="font-size: 20px; color: #007BFF">
            <asp:TextBox ID="NID" runat="server"></asp:TextBox>
        </div>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Show number of not resolved tickets" CssClass="custom-button" OnClick="Button1_Click" />
        </p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Column1" HeaderText="Number of not resolved tickets" ReadOnly="True" SortExpression="Column1" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Telecom_Team_10;Integrated Security=True;Encrypt=True" ProviderName="System.Data.SqlClient" SelectCommand="Ticket_Account_Customer" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="NID" Name="NID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Back" CssClass="custom-button" OnClick="Button2_Click" />
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
