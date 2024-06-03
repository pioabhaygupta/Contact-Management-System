package com.example.contactmanagementsystem.controller;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
public class SearchController {
    @Autowired
    UserService userService;

    //Search Handler
    @GetMapping("/search")
    public ResponseEntity<?> searchContact(@RequestParam("query") String query, Principal principal){
        //Current logged-in user
        User user = userService.getUser(principal.getName());

        List<Contact> contacts = userService.searchContact(query,user);

        return ResponseEntity.ok(contacts);
    }
}
