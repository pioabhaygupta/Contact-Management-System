package com.example.contactmanagementsystem.controller;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.FileNotSelectedException;
import com.example.contactmanagementsystem.helper.Message;
import com.example.contactmanagementsystem.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.Principal;
import java.util.Base64;
import java.util.List;


@Controller
@Slf4j
@RequestMapping("/user")
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    //method for adding common data to response
    @ModelAttribute
    public void addCommonData(Model model, Principal principal) {
        String email = principal.getName(); //currently authenticated user
        log.info("Username is : {}", email);
        User user = userService.getUser(email);
        model.addAttribute("user", user);
    }


    @GetMapping("/dashboard")
    public String dashboard(Model model, Principal principal) {
        model.addAttribute("title", "User Dashboard");
        return "normal/user_dashboard";
    }

    @GetMapping("/add-contact")
    public String openAddContactForm(Model model) {
        model.addAttribute("title", "Add Contact");
        model.addAttribute("contact", new Contact());
        return "normal/add_contact_form";
    }

    @PostMapping("/process-contact")
    public String processContact(@ModelAttribute("contact") Contact contact, @RequestParam("imageFile") MultipartFile imageFile
            , Model model, Principal principal, HttpSession session) {

        log.info("contact data: {}", contact);
        try {
            if (imageFile.isEmpty()) {
                throw new FileNotSelectedException("Please select an image to upload!");
            }
            byte[] bytes = imageFile.getBytes();
            String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);
            String email = principal.getName();
            User user = userService.getUser(email);
            userService.processContact(contact, base64EncodedImage, user);
            session.setAttribute("message", new Message("Your Contact added successfully !! Add More.... ", "alert-success"));
            model.addAttribute("contact", new Contact());
        } catch (Exception e) {
            model.addAttribute("contact", contact);
            session.setAttribute("message", new Message("Something went wrong !! " + e.getMessage(), "alert-danger"));
            return "normal/add_contact_form";
        }

        return "normal/add_contact_form";
    }

    @GetMapping("/show-contacts/{page}")
    public String showContacts(@PathVariable("page") Integer page, Model model, Principal principal) {
        model.addAttribute("title", "Show User Contacts");
        String email = principal.getName();
        User user = userService.getUser(email);

        //current page :- page
        //contact per page:- 5
        Pageable pageable = PageRequest.of(page, 2);
        Page<Contact> contactList = userService.findbyUserId(user.getId(), pageable);
        model.addAttribute("contacts", contactList.getContent());
        model.addAttribute("currentPage", page);
        int totalPages = contactList.getTotalPages();
        model.addAttribute("totalPages", totalPages);

        return "normal/show_contacts";
    }

}
