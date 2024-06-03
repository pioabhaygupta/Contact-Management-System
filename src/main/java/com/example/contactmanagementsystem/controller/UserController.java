package com.example.contactmanagementsystem.controller;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.FileNotSelectedException;
import com.example.contactmanagementsystem.exception.UnauthorizedAccessException;
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

    //contact form handler
    @GetMapping("/add-contact")
    public String openAddContactForm(Model model) {
        model.addAttribute("title", "Add Contact");
        model.addAttribute("contact", new Contact());
        return "normal/add_contact_form";
    }

    //add the User contact into the DB
    @PostMapping("/process-contact")
    public String processContact(@ModelAttribute("contact") Contact contact, @RequestParam("imageFile") MultipartFile imageFile
            , Model model, Principal principal, HttpSession session) {

        log.info("contact data: {}", contact);
        try {
            if (imageFile.isEmpty()) {
                throw new FileNotSelectedException("Please select an image to upload!");
            }
            //Encoding the image file into text using Base64 Encoder to store in the DB
            byte[] bytes = imageFile.getBytes();
            String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);

            //Fetching details of current logged-in user
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

    //Show all the contacts of a particular user in pages
    @GetMapping("/show-contacts/{page}")
    public String showContacts(@PathVariable("page") Integer page, Model model, Principal principal, HttpSession session) {
        model.addAttribute("title", "Show User Contacts");

        //current authenticated(logged-in) user details
        String email = principal.getName();
        User user = userService.getUser(email);

        //current page :- page
        //contact per page:- 4
        Pageable pageable = PageRequest.of(page, 4);

        //Fetching the user contact list with the help of user id
        Page<Contact> contactList = userService.getUserContacts(user.getId(), pageable);

        model.addAttribute("contacts", contactList.getContent());
        model.addAttribute("currentPage", page);
        session.setAttribute("currentPage", page);

        int totalPages = contactList.getTotalPages();
        model.addAttribute("totalPages", totalPages);

        return "normal/show_contacts";
    }

    //show a particular contact all details
    @GetMapping("/{id}/contact")
    public String showContactDetail(@PathVariable("id") int id, Model model, Principal principal) {
        model.addAttribute("title", "Contact Detail");
        try {
            Contact contact = userService.getContactById(id);

            // fetching current logged-in user
            String email = principal.getName();
            User user = userService.getUser(email);

            //if current logged-in user try to access the contact of another user by making changes in url
            if (user.getId() != contact.getUser().getId()) {
                throw new UnauthorizedAccessException("You don't have permission to see this contact..");
            }
            model.addAttribute("contact", contact);
        } catch (Exception e) {
            model.addAttribute("message", e.getMessage());
            return "normal/contact_detail";
        }

        return "normal/contact_detail";
    }

    @GetMapping("/delete/{id}")
    public String deleteContact(@PathVariable("id") int id, Model model, Principal principal, HttpSession session) {
        //Fetching the currentPage to redirect the same page after deleting the contact
        Integer currentPage = (Integer) session.getAttribute("currentPage");
        try {
            //Fetching details of current logged-in user to check whether user id is related to the contact or not
            String email = principal.getName();
            User user = userService.getUser(email);

            userService.deleteContact(id, user);
            session.setAttribute("message", new Message("Contact deleted successfully!!", "alert-success"));

        } catch (Exception e) {
            session.setAttribute("message", new Message(e.getMessage(), "alert-danger"));
            return "redirect:/user/show-contacts/" + currentPage;
        }
        return "redirect:/user/show-contacts/" + currentPage;
    }

    //open update form handler
    @PostMapping("/update-contact/{id}")
    public String updateContactForm(@PathVariable("id") int id, Model model) {
        model.addAttribute("title", "Update Contact");

        Contact contact = userService.getContactById(id);
        model.addAttribute("contact", contact);
        return "normal/update_form";
    }

    @PostMapping("/process-update")
    public String processUpdate(@ModelAttribute Contact contact, @RequestParam("imageFile") MultipartFile imageFile
            , Model model, HttpSession session, Principal principal) {
        Integer currentPage = (Integer) session.getAttribute("currentPage");
        try {
            if (!imageFile.isEmpty()) {
                byte[] bytes = imageFile.getBytes();
                String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);
                contact.setImage(base64EncodedImage);
            }
            User user = userService.getUser(principal.getName());
            userService.processUpdate(contact, user);
            session.setAttribute("message", new Message("Contact Updated Successfully!!", "alert-success"));

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/user/show-contacts/" + currentPage;
    }

    @GetMapping("/profile")
    public String yourProfile(Model model) {
        model.addAttribute("title", "Your Profile");
        return "normal/profile";
    }

    //open change password form handler
    @GetMapping("/change-password")
    public String changePasswordForm(Model model) {
        model.addAttribute("title", "Change Password");
        return "normal/change_pass";
    }

 //Update password
    @RequestMapping(path = "/process-password", method = RequestMethod.POST)
    public String processPassword(@RequestParam("oldPassword") String oldPassword
            , @RequestParam("newPassword") String newPassword, Principal principal, HttpSession session) {

        try{
            User currentUser = userService.getUser(principal.getName());
            userService.processPassword(oldPassword,newPassword, currentUser);
            session.setAttribute("message",new Message("Your password is successfully changed!!", "alert-success"));

        } catch (Exception e) {
            session.setAttribute("message",new Message(e.getMessage(),"alert-danger"));
            return "redirect:/user/change-password";
        }
        return "redirect:/user/change-password";
    }

    @GetMapping("/edit-profile")
    public String editProfileForm(Model model) {
        model.addAttribute("title", "Update Profile");
        return "normal/edit_profile";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@ModelAttribute("user") User user, @RequestParam("imageFile") MultipartFile imageFile
            , HttpSession session){
        try{
            if (!imageFile.isEmpty()) {
                byte[] bytes = imageFile.getBytes();
                String base64EncodedImage = Base64.getEncoder().encodeToString(bytes);
                user.setImageUrl(base64EncodedImage);
            }
            userService.updateProfile(user);

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "redirect:/user/edit-profile";

    }
}
