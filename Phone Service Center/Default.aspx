<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Phone_Service_Center._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container text-center">
        <h1 class="welcome-title">Welcome to the Phone Service Center</h1>
        <p>We are here to help you with all your phone service needs. Please explore our services and contact us if you have any questions.</p>

        <div class="dashboard-container">
            <div class="dashboard-card">
                <i class="fas fa-ticket-alt"></i>
                <h3>Total Tickets</h3>
                <asp:Label ID="lblTotalTickets" runat="server" CssClass="dashboard-count">0</asp:Label>
            </div>

            <div class="dashboard-card" id="adminAssignedTickets" runat="server" Visible="false">
                <i class="fas fa-user-check"></i>
                <h3>Assigned Tickets</h3>
                <asp:Label ID="lblAssignedTickets" runat="server" CssClass="dashboard-count">0</asp:Label>
            </div>

            <div class="dashboard-card" id="engineerRejectTickets" runat="server" Visible="false">
                <i class="fas fa-user-times"></i>
                <h3>Rejected Tickets</h3>
                <asp:Label ID="lblRejectTickets" runat="server" CssClass="dashboard-count">0</asp:Label>
            </div>

            <div class="dashboard-card">
                <i class="fas fa-check-circle"></i>
                <h3>Closed Tickets</h3>
                <asp:Label ID="lblClosedTickets" runat="server" CssClass="dashboard-count">0</asp:Label>
            </div>
        </div>
    </div>

    <!-- About Us Section -->
    <section class="about-section">
        <div class="container text-center">
            <h2>About Us</h2>
            <p>At Phone Service Center, we specialize in providing top-notch repair services for all mobile devices. Our dedicated team is committed to ensuring your device is back in perfect condition in no time. Customer satisfaction is our priority!</p>
        </div>
    </section>

    <!-- Contact Us Section -->
    <section class="contact-section">
        <div class="container text-center">
            <h2>Contact Us</h2>
            <p>If you have any questions or need assistance, feel free to reach out to us:</p>
            <p><strong>Email:</strong> <a href="mailto:support@phoneservicecenter.com">support@phoneservicecenter.com</a></p>
            <p><strong>Phone:</strong> (123) 456-7890</p>
        </div>
    </section>

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }

        .welcome-title {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 2.5rem;
            font-weight: 700;
        }

        .dashboard-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .dashboard-card {
            background-color: #ffffff;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            width: 220px;
            position: relative;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card h3 {
            margin: 15px 0;
            color: #e74c3c;
            font-size: 1.5rem;
            font-weight: 600;
        }

        .dashboard-count {
            font-size: 32px;
            font-weight: bold;
            color: #34495e;
        }

        .about-section, .contact-section {
            background-color: #ffffff;
            padding: 40px 20px;
            margin: 40px 0;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .about-section h2, .contact-section h2 {
            color: #2980b9;
            margin-bottom: 20px;
            font-size: 2rem;
            font-weight: 600;
        }

        .about-section p, .contact-section p {
            color: #555;
            font-size: 1.1rem;
            line-height: 1.6;
            margin: 10px 0;
        }

        /* Media Queries for Responsiveness */
        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
                align-items: center;
            }

            .dashboard-card {
                width: 90%;
            }

            .welcome-title {
                font-size: 2rem;
            }

            .about-section h2, .contact-section h2 {
                font-size: 1.5rem;
            }
        }
    </style>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha384-k6RqeWeci5ZR/Lv4MR0sA0FfDOMY2WlR4s4z5aW1CgFfJxN/A0t8DJ/nkq7kp8z" crossorigin="anonymous">
</asp:Content>
