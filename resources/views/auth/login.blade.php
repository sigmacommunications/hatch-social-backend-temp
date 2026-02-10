<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="/admin/assets/images/fav.png">
    <title>Login - Hatch Social</title>
    <link rel="stylesheet" href="/admin/assets/css/style.css">
    <link rel="stylesheet" type="text/css" 
     href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
</head>

<body>
    <section class="signupsec">
        <div class="form-container">
            <div class="container">
                <div class="div-logo">
                    <a href="./index.html"><img src="/admin/assets/images/logo.png" /></a>
                </div>
                <div class="content">
                    <h2>SIGN IN</h2>
                    <p>Enter Your Email & Password to Login</p>
                </div>
                <form method="post" action="{{route('admin_post')}}">
                @csrf
                    <div class="form-row">
                        <input type="text" name="email" placeholder="Email Address" required>
                    </div>
                    <div class="form-row form-btn">
                        <input type="password" id="password" name="password" placeholder="Password" required>
                        <span class="toggle-password" onclick="togglePassword()">👁</span>
                    </div>

                    <div class="extra-options">
                        <label>
                            <input type="radio" name="rememberMe"> Remember Me
                        </label>
                        <a href="{{url('password/reset')}}">Forgot Password?</a>
                    </div>

                    <button type="submit" class="signup-btn">Sign In</button>
                    <div class="text">
                        <p>Don't Have Account? <a href="./signup.html"> Create Account </a></p>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>

    <script>
        function togglePassword() {
            var passwordField = document.getElementById("password");
            var type = passwordField.getAttribute("type") === "password" ? "text" : "password";
            passwordField.setAttribute("type", type);
        }
    </script>
<script>
  @if(Session::has('success'))
  toastr.options =
  {
  	"closeButton" : true,
  	"progressBar" : true
  }
  		toastr.success("{{ session('success') }}");
  @endif

  @if(Session::has('error'))
  toastr.options =
  {
  	"closeButton" : true,
  	"progressBar" : true
  }
  		toastr.error("{{ session('error') }}");
  @endif


</script>
</body>

</html>