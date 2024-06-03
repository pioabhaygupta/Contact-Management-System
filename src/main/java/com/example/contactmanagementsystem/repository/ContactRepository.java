package com.example.contactmanagementsystem.repository;

import com.example.contactmanagementsystem.entities.Contact;
import com.example.contactmanagementsystem.entities.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ContactRepository extends JpaRepository<Contact,Integer> {
    //JPQL
    @Query("SELECT c FROM Contact c WHERE c.user.id = :id")
    Page<Contact> findByUserId(int id, Pageable pageable);

    // will return all the matching contact of current user
    public List<Contact> findByNameContainingAndUser(String keywords, User user);

}
