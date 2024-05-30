package com.example.contactmanagementsystem.service;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserService {
    User doRegister(User user);

    User getUser(String email);

    void processContact(Contact contact, String base64EncodedImage, User user);

    Page<Contact> findbyUserId(int id, Pageable pageable);
}
