package com.ders.bm470.model;

import jakarta.persistence.*;
import lombok.*;

import jakarta.persistence.*;
import java.util.*;

@Setter
@Getter
@Entity
@Table(name = "user")
public class User {
    // Getters and setters
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;


    private String firstName;
    private String lastName;


    @ElementCollection(fetch = FetchType.EAGER)
    private List<String> roles = new ArrayList<>();

}

