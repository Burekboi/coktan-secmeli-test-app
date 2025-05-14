package com.ders.bm470.controller;

import com.ders.bm470.model.User;
import com.ders.bm470.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    // Giriş sayfasını göster
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }

    @GetMapping("/logout")
    public String showLoginPageLogout() {
        return "login";
    }



    // Kayıt formunu işleme al
    @PostMapping("/register")
    public String registerUser(@ModelAttribute("user") User user, Model model) {
        if (userService.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "Bu kullanıcı adı zaten kullanılıyor.");
            return "login";
        }

        userService.register(user);
        return "redirect:/login?registered"; // login'e yönlendir, başarı mesajı parametresiyle
    }
}
