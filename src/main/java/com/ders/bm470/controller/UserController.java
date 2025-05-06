package com.ders.bm470.controller;

import com.ders.bm470.model.User;
import com.ders.bm470.service.TestService;
import com.ders.bm470.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    private final TestService testService;

    public UserController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping
    public String userHome(Model model) {
        model.addAttribute("tests", testService.getAllTests());
        return "user";
    }



    @GetMapping("/profile")
    public String userProfile(Model model, Principal principal) {
        String username = principal.getName();        // Giriş yapan kullanıcının kullanıcı adı
        User user = userService.findByUsername(username);
        model.addAttribute("user", user);
        return "profile";   // profile.jsp görünümünü döner
    }
}
