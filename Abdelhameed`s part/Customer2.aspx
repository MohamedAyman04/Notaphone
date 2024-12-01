<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer2.aspx.cs" Inherits="Abdelhameed_s_part.Customer2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="background-color: #D4D9D5;">
    <form id="form1" runat="server">
        <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 220px; gap: 40px;">
        <br />
            <div style="display: flex; gap: 20px;">
                <asp:Button ID="btnActiveBenefits" runat="server" Text="Active Benefits" CssClass="custom-button" OnClick="ActiveBenefitsClick" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnNotResolvedTickets" runat="server" Text="Not Resolved Tickets" CssClass="custom-button" OnClick="NotResolvedTicketsClick" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnHighestVoucher" runat="server" Text="Highest Voucher" CssClass="custom-button" OnClick="HighestVoucherClick" />
                <br />
                <br />
            </div>

            <div style="display: flex; gap: 20px;">
                <asp:Button ID="btnRemainingAmount" runat="server" Text="Remaining Amount" CssClass="custom-button" OnClick="RemainingAmountClick" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnExtraAmount" runat="server" Text="Extra Amount" CssClass="custom-button" OnClick="ExtraAmountClick" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnTopSuccessfulPayaments" runat="server" Text="Top Successful Payments" CssClass="custom-button" OnClick="TopSuccessfulPaymentsClick" />
            </div>
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
