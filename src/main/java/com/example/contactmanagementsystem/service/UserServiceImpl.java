package com.example.contactmanagementsystem.service;

import com.example.contactmanagementsystem.entities.User;
import com.example.contactmanagementsystem.repository.UserRepository;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
    UserRepository userRepository;
    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User doRegister(User user) {
        //Bcrypt Password Encoder
        user.setRole("ROLE_USER");
        user.setEnabled(true);
        return userRepository.save(user);
    }
}
