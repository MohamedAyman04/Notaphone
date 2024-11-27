<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TSP.aspx.cs" Inherits="Abdelhameed_s_part.TSP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="paymentID" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="paymentID" HeaderText="paymentID" InsertVisible="False" ReadOnly="True" SortExpression="paymentID" />
                    <asp:BoundField DataField="amount" HeaderText="amount" SortExpression="amount" />
                    <asp:BoundField DataField="date_of_payment" HeaderText="date_of_payment" SortExpression="date_of_payment" />
                    <asp:BoundField DataField="payment_method" HeaderText="payment_method" SortExpression="payment_method" />
                    <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                    <asp:BoundField DataField="mobileNo" HeaderText="mobileNo" SortExpression="mobileNo" />
                </Columns>
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
            <asp:Button ID="Button1" runat="server" Text="Back" OnClick="Button1_Click" />
        </div>
    </form>
</body>
</html>
