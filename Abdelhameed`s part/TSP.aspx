<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TSP.aspx.cs" Inherits="Abdelhameed_s_part.TSP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: #D4D9D5;">
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="paymentID" DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="paymentID" HeaderText="paymentID" InsertVisible="False" ReadOnly="True" SortExpression="paymentID" />
                    <asp:BoundField DataField="amount" HeaderText="amount" SortExpression="amount" />
                    <asp:BoundField DataField="date_of_payment" HeaderText="date_of_payment" SortExpression="date_of_payment" />
                    <asp:BoundField DataField="payment_method" HeaderText="payment_method" SortExpression="payment_method" />
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                    <asp:BoundField DataField="mobileNo" HeaderText="mobileNo" SortExpression="mobileNo" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Telecom_Team_10;Integrated Security=True;Encrypt=True" ProviderName="System.Data.SqlClient" SelectCommand="Top_Successful_Payments" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="mobile_num" SessionField="mobno" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Back" CssClass="custom-button" OnClick="Button1_Click" />
        </div>
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
