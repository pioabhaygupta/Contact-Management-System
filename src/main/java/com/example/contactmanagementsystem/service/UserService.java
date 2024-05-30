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

    Page<Contact> getUserContacts(int id, Pageable pageable);

    Contact getContactById(int id);

    void deleteContact(int id, User user);

    void processUpdate(Contact contact, User user);
}
