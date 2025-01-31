<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Presale | Dapps</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  @vite(['resources/css/app.css', 'resources/js/app.js'])
  <style>
    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(135deg, #4a90e2, #9013fe);
      color: #f9f9f9;
      margin: 0;
      padding: 0;
    }
    .hero-section {
      text-align: center;
      margin-top: 10px;
    }
    .countdown {
      font-size: 24px;
      font-weight: bold;
    }
    .buy-section {
      background: rgba(255, 255, 255, 0.1);
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
      padding: 20px;
      border-radius: 8px;
      color: #fff;
    }
    .footer {
      background: rgba(0, 0, 0, 0.8);
      color: #fff;
      margin-top: 100px;
      padding: 20px 0;
      text-align: center;
    }
    .footer a {
      color: #fff;
      text-decoration: none;
    }
  </style>
</head>
<body>

 <div id="app"></div>

<!-- Footer -->
<footer class="footer">
  <p>&copy; 2025 TokenX. All Rights Reserved.</p>
  <p><a href="#">Privacy Policy</a> | <a href="#">Terms & Conditions</a></p>
</footer>

<script>
  // Countdown Timer
  const countdown = document.getElementById('countdown-timer');
  const endDate = new Date().getTime() + (7 * 24 * 60 * 60 * 1000); // 7 days from now

  function updateCountdown() {
    const now = new Date().getTime();
    const timeLeft = endDate - now;

    if (timeLeft > 0) {
      const days = Math.floor(timeLeft / (1000 * 60 * 60 * 24));
      const hours = Math.floor((timeLeft % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((timeLeft % (1000 * 60)) / (1000 * 60));
      const seconds = Math.floor((timeLeft % (1000)) / 1000);
      countdown.textContent = ${days}d ${hours}h ${minutes}m ${seconds}s;
    } else {
      countdown.textContent = "Presale Ended";
    }
  }

  setInterval(updateCountdown, 1000);
</script>

</body>
</html>
