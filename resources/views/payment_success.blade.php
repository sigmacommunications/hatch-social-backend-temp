<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Subscription Plans</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Bootstrap 5 CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">

  <style>
    body {
      background: url('/admin/assets/images/success-background.png');
	    background-repeat: no-repeat center center fixed;
      font-family: "Montserrat", sans-serif;
      background-size: cover;
      min-height: 100vh;
      padding: 20px 10px;
      position: relative;
    }

    .subscription-box {
      border-radius: 30px;
      padding: 30px;
      color: #fff;
      box-shadow: 0 5px 20px rgba(0,0,0,0.15);
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      height: 100%;
    }

    .basic {
      background-color: #F4397A;
      border: 4px solid #018900;
    }

    .premium {
      background-color: #333;
      border: 4px solid #F4C900;
    }

    .subscription-title {
      font-size: 20px;
      font-weight: 700;
      text-align: center;
    }

    .subscription-price {
      font-size: 18px;
      text-align: center;
      margin-bottom: 20px;
    }

    .features {
      list-style: none;
      padding-left: 0;
      margin-top: 20px;
      margin-bottom: 30px;
    }

    .features li {
      display: flex;
      align-items: center;
      margin-bottom: 12px;
      font-size: 16px;
    }

    .features li::before {
      content: '';
      background: url('https://cdn-icons-png.flaticon.com/512/190/190411.png') no-repeat center center;
      background-size: cover;
      width: 22px;
      height: 22px;
      display: inline-block;
      margin-right: 10px;
      flex-shrink: 0;
    }

    .audience {
      text-align: center;
      font-size: 18px;
      font-weight: 700;
    }

    .subscribe-btn {
      border-radius: 40px;
      border: 2px solid rgba(255,255,255,0.5);
      text-align: center;
      padding: 10px;
      margin-top: 20px;
      font-weight: bold;
      opacity: 0.8;
      color: #fff;
      background-color: rgba(255,255,255,0.2);
      transition: 0.3s;
    }

    .subscribe-btn:hover {
      opacity: 1;
      cursor: pointer;
      text-decoration: none;
    }

    @media (min-width: 768px) {
      .plan-grid {
        display: flex;
        gap: 30px;
        align-items: stretch;
      }

      .plan-col {
        flex: 1;
      }
    }

    @media (max-width: 767px) {
      .subscription-box {
        padding: 20px;
        margin-bottom: 20px;
      }

      .subscription-title {
        font-size: 18px;
      }

      .subscription-price {
        font-size: 16px;
      }

      .features li {
        font-size: 14px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="text-center mb-5">
    <img src="/admin/assets/images/logo.png" alt="logo" style="vertical-align: middle;">
    <span style="font-family: monospace; font-size: 22px; font-weight: bold;"> MemberShip</span>
  </div>

	<div class="container text-center py-5">
		<h2 class="text-success">🎉 Payment Successful!</h2>
		<p>Thank you for subscribing to our plan. You can now enjoy your benefits.</p>
	</div>
</div>
</body>
</html>