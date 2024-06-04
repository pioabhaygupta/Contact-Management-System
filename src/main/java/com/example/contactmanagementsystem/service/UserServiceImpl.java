package com.example.contactmanagementsystem.service;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.exception.ContactNotFoundException;
import com.example.contactmanagementsystem.exception.DuplicateEntryException;
import com.example.contactmanagementsystem.exception.PasswordMismatchException;
import com.example.contactmanagementsystem.exception.UnauthorizedAccessException;
import com.example.contactmanagementsystem.repository.ContactRepository;
import com.example.contactmanagementsystem.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

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
        if (checkUser != null) {
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
    public Page<Contact> getUserContacts(int id, Pageable pageable) {
        return contactRepository.findByUserId(id, pageable);
    }

    @Override
    public Contact getContactById(int id) {
        Optional<Contact> contactOptional = contactRepository.findById(id);
        if (!contactOptional.isPresent()) {
            throw new ContactNotFoundException("Contact not found!!");
        }
        return contactOptional.get();
    }

    @Override
    public void deleteContact(int id, User user) {
        Optional<Contact> contactOptional = contactRepository.findById(id);
        if (!contactOptional.isPresent()) {
            throw new ContactNotFoundException("Contact not found");
        }
        Contact contact = contactOptional.get();
        if (user.getId() != contact.getUser().getId()) {
            throw new UnauthorizedAccessException("You don't have permission to delete this contact..");
        }
        contactRepository.delete(contact);
    }

    @Override
    public void processUpdate(Contact contact, User user) {
        contact.setUser(user);
        contactRepository.save(contact);
    }

    @Override
    public List<Contact> searchContact(String query, User user) {
        return contactRepository.findByNameContainingAndUser(query,user);
    }

    @Override
    public void processPassword(String oldPassword, String newPassword, User currentUser) {
        if(passwordEncoder.matches(oldPassword,currentUser.getPassword())){
            currentUser.setPassword(passwordEncoder.encode(newPassword));
            userRepository.save(currentUser);
        }else{
            throw new PasswordMismatchException("Given password is wrong!");
        }
    }

    @Override
    public void updateProfile(User user) {
        userRepository.save(user);
    }

    @Override
    public void changePassword(User user, String password) {
        user.setPassword(passwordEncoder.encode(password));
        userRepository.save(user);
    }
}
