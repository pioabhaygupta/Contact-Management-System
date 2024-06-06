package com.example.contactmanagementsystem.controller;

import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.AgreementNotCheckedException;
import com.example.contactmanagementsystem.exception.PasswordMismatchException;
import com.example.contactmanagementsystem.exception.UserNotFoundException;
import com.example.contactmanagementsystem.helper.Message;
import com.example.contactmanagementsystem.service.EmailService;
import com.example.contactmanagementsystem.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.Timestamp;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Random;

@Controller
@Slf4j
public class HomeController {
    private UserService userService;
    private EmailService emailService;
    Random random = new Random(1000);

    public HomeController(UserService userService, EmailService emailService) {
        this.userService = userService;
        this.emailService = emailService;
    }

    @RequestMapping("/")
    public String home() {
        return "home";
    }

    @RequestMapping("/signup")
    public String signup(Model model) {
        model.addAttribute("user", new User());
        return "signup";
    }

    @RequestMapping("/about")
    public String about() {
        return "about";
    }

    //Handler to register the user
    @PostMapping("/do-register")
    public String doRegister(@Valid @ModelAttribute("user") User user, BindingResult bindingResult, @RequestParam(value = "agreement", defaultValue = "false")
    boolean agreement, Model model, HttpSession session) {
        try {
            if (!agreement) {
                throw new AgreementNotCheckedException("Please check the terms and condition!!");
            }
            if (bindingResult.hasErrors()) {
                session.setAttribute("termsChecked", "checked");
                model.addAttribute("user", user);
                return "signup";
            }
            User result = userService.doRegister(user);
            log.info("User Details: {}", result);

            model.addAttribute("user", new User());
            session.setAttribute("message",
                    new Message("Successfully Registered !!", "alert-success"));

        } catch (Exception e) {
            model.addAttribute("user", user);
            session.setAttribute("message",
                    new Message("Something went wrong : " + e.getMessage(), "alert-danger"));
            return "signup";
        }
        return "signup";
    }


    @RequestMapping("/login")
    public String customLogin(Model model) {
        model.addAttribute("title", "login page");
        return "login";
    }

    //Forgot password handler
    @RequestMapping("/forgot")
    public String openEmailForm() {
        return "forgot_email_form";
    }

    @PostMapping("/send-otp")
    public String sendOtp(@RequestParam("email") String email, HttpSession session) {
        try {
            // checking whether e-mail address is assigned to any user account or not
            User user = userService.getUser(email);
            if (user == null) {
                throw new UserNotFoundException("The e-mail address is not assigned to any user account");
            }
            //generating 4 digit otp to reset the password
            int otp = random.nextInt(9999);
            LocalDateTime timestamp = LocalDateTime.now();
            log.info("OTP: {}", otp);

            String subject = "One Time Password for Verification SCM";
            String body = " "
                    + "<div style='border: 2px solid black; padding: 20px;'>"
                    + "<p>Dear User,</p>"
                    + "<p>Your one time password for reseting password is :<b> " + otp + "</b>.</p>"
                    + "</div>";

            emailService.sendEmailToUser(email, subject, body);
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            session.setAttribute("timestamp", timestamp);

        } catch (Exception e) {
            session.setAttribute("message", new Message(e.getMessage(), "alert-danger"));
            return "redirect:/forgot";
        }
        session.setAttribute("message", new Message("We have sent an OTP to your registered email id!", "alert-success"));
        return "verify_otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam("otp") Integer otp, HttpSession session) {
        Integer myOtp = (Integer) session.getAttribute("otp");

        LocalDateTime currentTimestamp = LocalDateTime.now();
        LocalDateTime otpTimestamp = (LocalDateTime) session.getAttribute("timestamp");

        Duration duration = Duration.between(otpTimestamp, currentTimestamp);
        log.info("duration:{}", duration);

        if (duration.toMinutes() > 2) {
            session.setAttribute("message", new Message("OTP has expired!", "alert-warning"));
            return "verify_otp";
        }
        //check whether form otp is matching with sent otp or not
        if (!Objects.equals(myOtp, otp)) {
            session.setAttribute("message", new Message("Entered OTP is wrong ! Please try again...", "alert-danger"));
            return "verify_otp";
        }
        return "change_password_form";

    }

    @PostMapping("/change-password")
    public String changePassword(@RequestParam("password") String password, @RequestParam("confirmPassword") String confirmPassword
            , HttpSession session) {
        try {
            String email = (String) session.getAttribute("email");
            //Fetching the current user to reset the password by email
            User user = userService.getUser(email);
            if (!password.equals(confirmPassword)) {
                throw new PasswordMismatchException("Passwords should be match!");
            }
            userService.changePassword(user, password);
            session.setAttribute("message", new Message("Password Changed Successfully!", "alert-success"));
        } catch (Exception e) {
            session.setAttribute("message", new Message(e.getMessage(), "alert-danger"));
            return "change_password_form";
        }
        return "change_password_form";
    }

}
