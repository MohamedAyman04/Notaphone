<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AcBs.aspx.cs" Inherits="Abdelhameed_s_part.AcBs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="benefitID" DataSourceID="SqlDataSource2" Width="569px">
            <Columns>
                <asp:BoundField DataField="benefitID" HeaderText="benefitID" InsertVisible="False" ReadOnly="True" SortExpression="benefitID" />
                <asp:BoundField DataField="description" HeaderText="description" SortExpression="description" />
                <asp:BoundField DataField="validity_date" HeaderText="validity_date" SortExpression="validity_date" />
                <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
                <asp:BoundField DataField="mobileNo" HeaderText="mobileNo" SortExpression="mobileNo" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Telecom_Team_10;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [allBenefits]"></asp:SqlDataSource>
        <br />
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="Back" OnClick="Button1_Click" />
    </form>
</body>
</html>
