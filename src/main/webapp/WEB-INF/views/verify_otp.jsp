<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="base.jsp" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Contact Manager</title>
    <style> <%@include file="/WEB-INF/static/css/style.css"%> </style>
  </head>
  <body>
    <section>
      <div id="login">
        <h3 class="text-center text-white pt-5"></h3>
          <div class="container">
            <!--Alert Message -->
              <div class="container col-md-6 mt-4">
                <c:if test="${not empty sessionScope.message}">
                  <div id="myAlert" class="alert ${sessionScope.message.type} text-center" role="alert">
                    <p>${sessionScope.message.content}</p>
                    <c:remove var="message" scope="session" />
                  </div>
                </c:if>
              </div>
            <div id="login-row" class="row justify-content-center align-items-center">
              <div id="login-column" class="col-md-6">
                <div id="login-box" style="height: 200px;" class="col-md-12">
                  <h3 class="text-center m-3">One Time Password</h3>
                  <form id="forgot-form" class="form" action="/verify-otp" method="post">

                    <div class="form-group">
                      <input type="text" name="otp" id="otp" class="form-control" placeholder="Enter OTP here"  required>
                      <div class="text-center">
                        <span  class="">Remaining Time: </span>
                        <span id="countdown" class=""> </span>
                      </div>
                    </div>

                    <div class="container text-center">
                      <button class="btn btn-warning">Verify OTP</button>
                      <a href="/forgot" class="btn btn-info">Resend OTP</a>
                    </div>

                  </form>
                </div>
              </div>
            </div>
          </div>
      </div>
    </section>

    <script type="text/javascript">

      // Strating countdown at the time of webpage loading
      window.onload = function () {
          var twoMinutes = 60*2; //in second
          var display = document.getElementById('countdown');
          startCountdown(twoMinutes,display);
      }

      function startCountdown(duration,display) {
          var timer = duration , minutes, seconds;

          // Updating countdown every 1 second  setInterval(function,time In Millisecond)
          var countdownInterval = setInterval(function(){
            minutes = Math.floor(timer/60);
            seconds = timer%60;

            // Formatting minutes and seconds
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            // Display
            display.textContent = minutes + ":" + seconds ;

            if(--timer < 0){
              clearInterval(countdownInterval);
              display.textContent = "OTP has expired!"
            }
          }, 1000);
      }
    </script>
  </body>
</html>