package com.example.contactmanagementsystem.service;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.DuplicateEntryException;
import com.example.contactmanagementsystem.repository.ContactRepository;
import com.example.contactmanagementsystem.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    UserRepository userRepository;
    BCryptPasswordEncoder passwordEncoder;
    ContactRepository contactRepository;

    public UserServiceImpl(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder, ContactRepository contactRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.contactRepository = contactRepository;
    }

    @Override
    public User doRegister(User user) {
        User checkUser = userRepository.findByEmail(user.getEmail());
        if(checkUser!=null){
            throw new DuplicateEntryException("Email aready registered");
        }
        //Bcrypt Password Encoder
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole("ROLE_USER");
        user.setEnabled(true);
        return userRepository.save(user);
    }

    @Override
    public User getUser(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public void processContact(Contact contact, String base64EncodedImage, User user) {
        contact.setUser(user);
        contact.setImage(base64EncodedImage);
        user.getContacts().add(contact);
        userRepository.save(user);
    }

    @Override
    public Page<Contact> findbyUserId(int id, Pageable pageable) {
        return contactRepository.findByUserId(id, pageable);
    }

}
