<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NRT.aspx.cs" Inherits="Abdelhameed_s_part.NRT" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Please type your National ID :<br />
        </div>
        <asp:TextBox ID="NID" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Number of not resolved tickets" OnClick="Button1_Click" />
        </p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="Column1" HeaderText="Number of not resolved tickets" ReadOnly="True" SortExpression="Column1" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=Telecom_Team_10;Integrated Security=True;Encrypt=True" ProviderName="System.Data.SqlClient" SelectCommand="Ticket_Account_Customer" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="NID" Name="NID" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" Text="Back" OnClick="Button2_Click" />
    </form>
</body>
</html>
