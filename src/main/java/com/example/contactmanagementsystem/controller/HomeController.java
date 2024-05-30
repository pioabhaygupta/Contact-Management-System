package com.example.contactmanagementsystem.controller;

import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.AgreementNotCheckedException;
import com.example.contactmanagementsystem.helper.Message;
import com.example.contactmanagementsystem.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@Slf4j
public class HomeController {
    UserService userService;

    public HomeController(UserService userService) {
        this.userService = userService;
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
                session.setAttribute("termsChecked","checked");
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
        model.addAttribute("title","login page");
        return "login";
    }

}
