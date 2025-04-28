package com.ders.bm470.controller;

import com.ders.bm470.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class HomeController {

    private final TestService testService;

    @Autowired
    public HomeController(TestService testService) {
        this.testService = testService;
    }

    @GetMapping("/home")
    public String home(Model model, Principal principal) {
        model.addAttribute("tests", testService.getAllTests());

        boolean isAdmin = principal != null && principal.getName().equals("admin"); // Burayı kendi admin kontrolüne göre düzenlersin
        model.addAttribute("isAdmin", isAdmin);

        return "home";
    }
}

